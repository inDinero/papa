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
            runner = Runner.new(queue(branch))

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

          success_and_failure_messages

          if !success
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

        def queue(branch)
          [
            Command::Git::Checkout.new(@build_branch),
            Command::Git::ResetHard.new('origin', @build_branch),
            Command::Git::Checkout.new(branch),
            Command::Git::ResetHard.new('origin', branch),
            Command::Git::Rebase.new(@build_branch),
            Command::Git::PushForce.new('origin', branch),
            Command::Git::Checkout.new(@build_branch),
            Command::Git::Merge.new(branch),
            Command::Git::BranchDelete.new(branch),
            Command::Git::Push.new('origin', @build_branch)
          ]
        end

        def check_if_branches_are_given
          return unless @branches.empty?
          require 'papa/helper/vi'
          vi_file_helper = Helper::Vi.new
          @branches = vi_file_helper.run
        end

        def success_and_failure_messages
          success_message
          failure_message
        end

        def success_message
          return if @success_branches.empty?
          Helper::Output.success "Successfully added these branches to #{@build_branch}:\n"
          info = ''
          @success_branches.each_with_index do |branch, index|
            info << "  #{index + 1}.) #{branch}\n"
          end
          Helper::Output.success_info info
        end

        def failure_message
          return if @failed_branches.empty?

          Helper::Output.failure "Failed to add these branches to #{@build_branch}:\n"
          info = ''
          @failed_branches.each_with_index do |failed_branch, index|
            branch = failed_branch[:branch]
            message = failed_branch[:message]
            info << "  #{index + 1}.) #{branch}\n"
            info << "      - #{message}\n"
          end
          info << "\n"

          branch_names = @failed_branches.map { |f| f[:branch] }
          info << "When the above problems are resolved, you can re-run this with:\n"
          info << "  papa #{@build_type} add -v #{@version} -b #{branch_names.join(' ')}"

          Helper::Output.failure_info info
        end
      end
    end
  end
end
