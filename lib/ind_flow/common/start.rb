module IndFlow
  class Common::Start
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      queue = CommandQueue.new
      queue.add Git.checkout(branch_name: @base_branch)
      queue.add Git.fetch(remote: 'origin')
      queue.add Git.branch(branch_name: @build_branch)
      queue.add Git.checkout(branch_name: @build_branch)
      queue.add Git.push(remote: 'origin', branch_name: @build_branch)

      queue.list_queue
    end
  end
end
