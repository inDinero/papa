module IndFlow
  class Common::Add
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      @branches.each do |branch|
        queue = CommandQueue.new
        queue.add Git.checkout(branch_name: branch)
        queue.add Git.pull(remote: 'origin', branch_name: branch)
        queue.add Git.rebase(base_branch_name: @build_branch)
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.merge(branch_name: branch)
        if !queue.run
          break
        end
      end
    end
  end
end
