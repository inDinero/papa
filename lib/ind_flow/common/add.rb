module IndFlow
  class Common::Add
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      queue = CommandQueue.new
      @branches.each do |branch|
        queue.add Git.checkout(branch_name: branch)
        queue.add Git.pull(remote: 'origin', branch_name: branch)
        queue.add Git.rebase(base_branch_name: @build_branch)
        queue.add Git.checkout(branch_name: @build_branch)
        queue.add Git.merge(branch_name: branch)
      end

      queue.run
    end
  end
end
