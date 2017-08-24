module IndFlow
  class Common::Add
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      success_branches = []

      @branches.each do |branch|
        queue = CommandQueue.new
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.checkout(branch_name: branch)
        queue.add Git.pull(remote: 'origin', branch_name: branch)
        queue.add Git.rebase(base_branch_name: @build_branch)
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.merge(branch_name: branch)
        if queue.run
          success_branches << branch
        else
          break
        end
      end

      @failed_branches = @branches - success_branches
      if !@failed_branches.empty?
        report_failure
      end
    end

    def report_failure
      puts "These branches failed:"
      @failed_branches.each do |branch|
        puts "  #{branch}"
      end
      puts "When the above problems are resolved, you can re-run this with:"
      puts "  ind_flow #{@build_type} add -v #{@version} -b #{@failed_branches.join(' ')}"
    end
  end
end
