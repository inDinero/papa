require 'papa/command/git/fetch'
require 'papa/command/git/checkout'
require 'papa/command/git/merge'
require 'papa/command/git/push'
require 'papa/command/git/tag'
require 'papa/command/git/tag_push'
require 'papa/runner'
require 'papa/helper/output'

module Papa
  module Task
    module Common
      class Finish
        def run
          @build_branch ||= "#{@build_type}/#{@version}"

          check_if_build_branch_exists

          success = true
          @success_branches = []

          @base_branches.each do |branch|
            runner = Runner.new(queue(branch))

            if runner.run
              @success_branches << branch
            else
              success = false
            end
          end

          if success
            success_message
          else
            failure_message
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
          queue = [
            Command::Git::Checkout.new(@build_branch),
            Command::Git::Checkout.new(branch),
            Command::Git::Merge.new(@build_branch),
            Command::Git::Push.new('origin', branch)
          ]
          if @tag_name && branch == 'master'
            queue << Command::Git::Tag.new(@tag_name)
            queue << Command::Git::TagPush.new('origin', @tag_name)
          end
          queue
        end

        def success_message
          Helper::Output.success "Successfully merged #{@build_branch} to these branches:\n"
          info = ''
          @success_branches.each_with_index do |branch, index|
            info << " #{index + 1}.) #{branch}\n"
          end
          Helper::Output.success_info info
        end

        def failure_message
          failed_branches = @base_branches - @success_branches
          Helper::Output.failure "Failed to merge #{@build_branch} to these branches:\n"
          info = ''
          failed_branches.each_with_index do |branch, index|
            info << " #{index + 1}.) #{branch}\n"
          end
          Helper::Output.failure_info info
        end
      end
    end
  end
end
