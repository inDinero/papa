module Papa
  class Common::Add
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      success = true
      @success_branches = []

      @branches.each do |branch|
        queue = CommandQueue.new
        queue.add Git.fetch(remote: 'origin')
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.checkout(branch_name: branch)
        queue.add Git.rebase(base_branch_name: @build_branch)
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.merge(branch_name: branch)
        queue.add Git.push(remote: 'origin', branch_name: @build_branch)
        if queue.run
          @success_branches << branch
        else
          success = false
        end
      end

      cleanup

      success_message if !@success_branches.empty?

      if !success
        failure_message
        exit 1
      end
    end

    private

    def success_message
      Output.stdout "Successfully added these branches to #{@build_branch}:"
      @success_branches.each do |branch|
        Output.stdout "  #{branch}"
      end
    end

    def cleanup
      queue = CommandQueue.new
      @branches.each { |branch| queue.add Git.delete_branch(branch_name: branch) }
      queue.run
    end

    def failure_message
      failed_branches = @branches - @success_branches

      Output.stderr "Failed to add these branches to #{@build_branch}:"
      failed_branches.each do |branch|
        Output.stderr "  #{branch}"
      end
      Output.stderr 'When the above problems are resolved, you can re-run this with:'
      Output.stderr "  papa #{@build_type} add -v #{@version} -b #{@failed_branches.join(' ')}"
    end
  end
end
