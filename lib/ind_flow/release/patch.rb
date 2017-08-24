module IndFlow
  class Release::Patch
    def initialize(version:, patch_branch:)
      @build_type = 'release'
      @version = version
      @patch_branch = patch_branch
    end

    def run
      @build_branch = "#{@build_type}/#{@version}"

      queue = CommandQueue.new
      queue.add Git.fetch(remote: 'origin')
      queue.add Git.checkout(branch_name: @build_branch)
      queue.add Git.checkout(branch_name: @patch_branch)
      queue.add Git.pull(remote: 'origin', branch_name: @patch_branch)
      queue.add Git.rebase(base_branch_name: @build_branch)
      queue.add Git.checkout(branch_name: @build_branch)
      queue.add Git.merge(branch_name: @patch_branch)
      queue.run
    end
  end
end
