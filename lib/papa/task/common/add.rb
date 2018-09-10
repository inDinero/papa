require 'papa/task/base'
require 'papa/command/git/reset_hard'
require 'papa/command/git/rebase'
require 'papa/command/git/push_force'
require 'papa/command/git/merge'
require 'papa/command/git/push'
require 'papa/command/git/branch_delete'

module Papa
  module Task
    module Common
      class Add < Base
        def initialize
          check_if_build_branch_exists
          check_if_branches_are_given
          check_if_branches_are_valid
          @success_branches = []
          @failed_branches = []
        end

        private

        def check_if_branches_are_given
          return unless @branches.empty?
          require 'papa/helper/vi'
          vi_file_helper = Helper::Vi.new
          @branches = vi_file_helper.run
        end

        def check_if_branches_are_valid
          return if @build_type == 'integration'
          invalid_branch_prefixes = ['hotfix', 'release']
          @branches.each do |branch|
            has_invalid_branches = invalid_branch_prefixes.any? do |invalid_branch_prefix|
              branch.start_with?(invalid_branch_prefix)
            end
            return unless has_invalid_branches
            Helper::Output.failure "Branch #{branch.bold} cannot be added to #{@build_type.bold} build branches."
            exit 1
          end
        end

        def perform_task
          @success = true
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
              @success = false
            end
          end
        end

        def queue(branch)
          [
            Command::Git::Checkout.new(build_branch),
            Command::Git::ResetHard.new('origin', build_branch),
            Command::Git::Checkout.new(branch),
            Command::Git::ResetHard.new('origin', branch),
            Command::Git::Rebase.new(build_branch),
            Command::Git::PushForce.new('origin', branch),
            Command::Git::Checkout.new(build_branch),
            Command::Git::Merge.new(branch),
            Command::Git::BranchDelete.new(branch),
            Command::Git::Push.new('origin', build_branch)
          ]
        end

        def result
          if @success_branches.count > 0
            success_message
          end
          if @failed_branches.count > 0
            failure_message
            exit 1
          end
        end

        def success_message
          success_message = "Successfully added these branches to #{build_branch}:\n"
          Helper::Output.success(success_message)
          info = ''
          @success_branches.each_with_index do |branch, index|
            info << "  #{index + 1}.) #{branch}\n"
          end
          Helper::Output.success_info info
        end

        def failure_message
          Helper::Output.failure "Failed to add these branches to #{build_branch}:\n"
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
