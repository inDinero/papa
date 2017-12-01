require 'papa/helper/output'
require 'papa/command/git/fetch'
require 'papa/command/git/checkout'
require 'papa/command/git/reset_hard'
require 'papa/command/git/rebase'
require 'papa/command/git/push_force'
require 'papa/command/git/merge'
require 'papa/command/git/push'
require 'papa/command/git/branch_delete'
require 'papa/runner'

module Papa
  module Task
    module Common
      class Add
        def run
          @build_branch ||= "#{@build_type}/#{@version}"

          check_if_build_branch_exists
          check_if_branches_are_given

          success = true
          @success_branches = []
          @failed_branches = []

          Helper::Output.stdout "Started adding branches to #{@build_branch.bold}."

          @branches.each_with_index do |branch, index|
            Helper::Output.stdout "Adding branch #{branch.bold} (#{index + 1} of #{@branches.count})..."
            queue = [
              Command::Git::Fetch.new('origin'),
              Command::Git::Checkout.new(@build_branch),
              Command::Git::Checkout.new(branch),
              Command::Git::ResetHard.new('origin', branch),
              Command::Git::Rebase.new(@build_branch),
              Command::Git::PushForce.new('origin', branch),
              Command::Git::Checkout.new(@build_branch),
              Command::Git::Merge.new(branch),
              Command::Git::Push.new('origin', @build_branch)
            ]
            runner = Runner.new(queue)

            if runner.run
              @success_branches << branch
            else
              failed_branch = {
                branch: branch,
                message: runner.last_error
              }
              @failed_branches << failed_branch
              success = false
            end
          end

          success_message
          failure_message

          if success
            success_cleanup
          else
            failure_cleanup
            exit 1
          end
        end

        private

        def check_if_build_branch_exists
          queue = [
            Command::Git::Fetch.new('origin'),
            Command::Git::Checkout.new(@build_branch)
          ]
          runner = Runner.new(queue)
          return if runner.run
          Helper::Output.failure 'Build branch does not exist.'
          exit 1
        end

        def check_if_branches_are_given
          return unless @branches.empty?
          require 'papa/helper/vi'
          vi_file_helper = Helper::Vi.new
          @branches = vi_file_helper.run
        end

        def success_cleanup
          queue = @branches.map { |branch| Command::Git::BranchDelete.new(branch) }
          Runner.new(queue).run
        end

        def success_message
          return if @success_branches.empty?
          output = ''
          output << "Successfully added these branches to #{@build_branch}:\n"
          @success_branches.each_with_index do |branch, index|
            output << "  #{index + 1}.) #{branch}\n"
          end
          Helper::Output.success output
        end

        def failure_cleanup
        end

        def failure_message
          return if @failed_branches.empty?

          output = ''

          output << "Failed to add these branches to #{@build_branch}:\n"
          @failed_branches.each_with_index do |failed_branch, index|
            branch = failed_branch[:branch]
            message = failed_branch[:message]
            output << "  #{index + 1}.) #{branch}\n"
            output << "      - #{message}\n"
          end

          output << "\n"

          branch_names = @failed_branches.map { |f| f[:branch] }

          output << "When the above problems are resolved, you can re-run this with:\n"
          output << "  papa #{@build_type} add -v #{@version} -b #{branch_names.join(' ')}"

          Helper::Output.failure output
        end
      end
    end
  end
end
