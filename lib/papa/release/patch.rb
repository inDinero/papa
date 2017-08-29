module Papa
  class Release::Patch < Common::Add
    def initialize(version:, patch_branch:)
      @build_type = 'release'
      @version = version
      @branches = [patch_branch]
    end

    # def run
    #   @build_branch = "#{@build_type}/#{@version}"
    #
    #   queue = CommandQueue.new
    #   queue.add Git.fetch(remote: 'origin')
    #   queue.add Git.checkout(branch_name: @build_branch)
    #   queue.add Git.checkout(branch_name: @patch_branch)
    #   queue.add Git.rebase(base_branch_name: @build_branch)
    #   queue.add Git.checkout(branch_name: @build_branch)
    #   queue.add Git.merge(branch_name: @patch_branch)
    #   queue.run
    #
    #   cleanup
    # end

    # def cleanup
    #   queue = CommandQueue.new
    #   @branches.each { |branch| queue.add Git.delete_branch(branch_name: branch) }
    #   queue.run
    # end
  end
end
