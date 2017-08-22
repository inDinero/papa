module IndFlow
  class CLI::AddToRelease
    def initialize(version:, feature_branches:)
      @version = version
      @feature_branches = feature_branches
    end
    
    def run
      release_branch_name = "release/#{@version}"

      queue = CommandQueue.new
      @feature_branches.each do |feature_branch|
        queue.add Git.checkout(branch_name: feature_branch)
        queue.add Git.rebase(base_branch_name: release_branch_name)
        queue.add Git.checkout(branch_name: release_branch_name)
        queue.add Git.merge(branch_name: feature_branch)
      end

      queue.list_queue
    end
  end
end
