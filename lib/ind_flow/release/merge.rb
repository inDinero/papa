module IndFlow
  class Release::Merge
    def initialize(version:)
      @version = version
    end

    def run
      release_branch_name = "release/#{@version}"
      tag_name = @version

      queue = CommandQueue.new

      # Merge to develop
      queue.add Git.checkout(branch_name: 'develop')
      queue.add Git.merge(branch_name: release_branch_name)
      queue.add Git.push(remote: 'origin', branch_name: 'develop')

      # Merge to master
      queue.add Git.checkout(branch_name: 'master')
      queue.add Git.merge(branch_name: release_branch_name)
      queue.add Git.push(remote: 'origin', branch_name: 'master')
      queue.add Git.tag(tag_name: tag_name)
      queue.add Git.push_tag(remote: 'origin', tag_name: tag_name)

      queue.list_queue
    end
  end
end
