module IndFlow
  class Hotfix::Finish
    def initialize(version:)
      @version = version
    end

    def run
      hotfix_branch_name = "hotfix/#{@version}"

      queue = CommandQueue.new
      queue.add Git.checkout(branch_name: hotfix_branch_name)
      queue.add Git.push(remote: 'origin', branch_name: hotfix_branch_name)

      queue.list_queue
    end
  end
end
