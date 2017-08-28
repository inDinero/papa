module IndFlow
  class Common::Finish
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      success = true
      @success_branches = []

      @base_branches.each do |branch|
        queue = CommandQueue.new
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

        if !success
          report_failure
          exit 1
        end
      end
    end

    private

    def report_failure
      failed_branches = @branches - @success_branches

      Output.stderr 'These branches failed:'
      failed_branches.each do |branch|
        Output.stderr "  #{branch}"
      end
      # TODO: Handle master or develop failure
      # Output.stderr "When the above problems are resolved, you can re-run this with:"
      # Output.stderr "  ind_flow #{@build_type} finish -v #{@version} -b #{@failed_branches.join(' ')}"
    end
  end
end
