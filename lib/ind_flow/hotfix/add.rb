module IndFlow
  class Hotfix::Add
    def initialize(version:, bugfix_branches:)
      @version = version
      @bugfix_branches = bugfix_branches
    end

    def run
      hotfix_branch_name = "hotfix/#{@version}"

      queue = CommandQueue.new
      @bugfix_branches.each do |bugfix_branch|
        queue.add Git.checkout(branch_name: bugfix_branch)
        queue.add Git.rebase(base_branch_name: hotfix_branch_name)
        queue.add Git.checkout(branch_name: hotfix_branch_name)
        queue.add Git.merge(branch_name: bugfix_branch)
      end

      queue.list_queue
    end
  end
end
