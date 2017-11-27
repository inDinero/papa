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
            queue = Runner.new
            queue.add Git.fetch(remote: 'origin')
            queue.add Git.checkout(branch_name: @build_branch)
            queue.add Git.checkout(branch_name: branch)
            queue.add Git.merge(branch_name: @build_branch)
            queue.add Git.push(remote: 'origin', branch_name: branch)
            if @tag_name && branch == 'master'
              queue.add Git.tag(tag_name: @tag_name)
              queue.add Git.push_tag(remote: 'origin', tag_name: @tag_name)
            end
            if queue.run
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
