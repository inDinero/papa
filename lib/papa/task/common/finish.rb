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

          success = true
          @success_branches = []

          @base_branches.each do |branch|
            queue = [
              Command::Git::Fetch.new('origin'),
              Command::Git::Checkout.new(@build_branch),
              Command::Git::Checkout.new(branch),
              Command::Git::Merge.new(@build_branch),
              Command::Git::Push.new('origin', branch)
            ]
            if @tag_name && branch == 'master'
              queue << Command::Git::Tag.new(@tag_name)
              queue << Command::Git::TagPush.new('origin', @tag_name)
            end
            runner = Runner.new(queue)

            if runner.run
              @success_branches << branch
            else
              success = false
            end
          end

          success_message if !@success_branches.empty?

          if !success
            failure_message
            exit 1
          end
        end

        private

        def success_message
          Helper::Output.stdout "Successfully merged #{@build_branch} to these branches:"
          @success_branches.each do |branch|
            Helper::Output.stdout "  #{branch}"
          end
        end

        def failure_message
          failed_branches = @base_branches - @success_branches

          Helper::Output.stderr "Failed to merge #{@build_branch} to these branches:"
          failed_branches.each do |branch|
            Helper::Output.stderr "  #{branch}"
          end
          # TODO: Handle master or develop failure
          # Helper::Output.stderr "When the above problems are resolved, you can re-run this with:"
          # Helper::Output.stderr "  papa #{@build_type} finish -v #{@version} -b #{failed_branches.join(' ')}"
        end
      end
    end
  end
end
