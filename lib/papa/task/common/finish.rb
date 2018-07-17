require 'papa/task/base'
require 'papa/command/git/merge'
require 'papa/command/git/reset_hard'
require 'papa/command/git/push'
require 'papa/command/git/tag'
require 'papa/command/git/tag_push'

module Papa
  module Task
    module Common
      class Finish < Base
        def initialize
          check_if_build_branch_exists
          @success_branches = []
          @failed_branches = []
        end

        private

        def perform_task
          @success = true
          @base_branches.each do |branch|
            runner = Runner.new(queue(branch))
            if runner.run
              @success_branches << branch
            else
              @failed_branches << branch
              @success = false
            end
          end
        end

        def queue(branch)
          queue = [
            Command::Git::Checkout.new(build_branch),
            Command::Git::ResetHard.new('origin', build_branch),
            Command::Git::Checkout.new(branch),
            Command::Git::ResetHard.new('origin', branch),
            Command::Git::Merge.new(build_branch),
            Command::Git::Push.new('origin', branch)
          ]
          if @tag_name && branch == 'master'
            queue << Command::Git::Tag.new(@tag_name)
            queue << Command::Git::TagPush.new('origin', @tag_name)
          end
          queue
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
          Helper::Output.success "Successfully merged #{build_branch} to these branches:\n"
          info = ''
          @success_branches.each_with_index do |branch, index|
            info << " #{index + 1}.) #{branch}\n"
          end
          Helper::Output.success_info info
        end

        def failure_message
          Helper::Output.failure "Failed to merge #{build_branch} to these branches:\n"
          info = ''
          @failed_branches.each_with_index do |branch, index|
            info << " #{index + 1}.) #{branch}\n"
          end
          Helper::Output.failure_info info
        end
      end
    end
  end
end
