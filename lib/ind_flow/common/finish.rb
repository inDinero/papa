module IndFlow
  class Common::Finish
    def run
      @build_branch ||= "#{@build_type}/#{@version}"

      queue = CommandQueue.new
      queue.add Git.checkout(branch_name: @build_branch)
      queue.add Git.push(remote: 'origin', branch_name: @build_branch)
      queue.run
    end
  end
end
