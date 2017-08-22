module IndFlow
  class CLI < Thor
    desc 'start_release', 'foo'
    def start_release
      release_branch_name = 'release/1.0.0'

      puts "Starting release branch **#{release_branch_name}**"
      queue = CommandQueue.new
      queue.add Git.checkout(branch_name: 'develop')
      queue.add Git.fetch(remote: 'origin')
      queue.add Git.branch(branch_name: release_branch_name)
      queue.add Git.checkout(branch_name: release_branch_name)
      queue.add Git.push(remote: 'origin', branch_name: release_branch_name)
      queue.list_queue
    end

    desc 'add_to_release', 'foo'
    def add_to_release
      release_branch_name = 'release/1.0.0'
      feature_branches = [
        'feature/1-add-foobars',
        'feature/2-make-foobars',
        'feature/3-eat-foobars'
      ]

      puts "Adding feature branches **#{feature_branches}** to **#{release_branch_name}**"

      queue = CommandQueue.new
      feature_branches.each do |feature_branch|
        queue.add Git.checkout(branch_name: feature_branch)
        queue.add Git.rebase(base_branch_name: release_branch_name)
        queue.add Git.checkout(branch_name: release_branch_name)
        queue.add Git.merge(branch_name: feature_branch)
      end

      queue.list_queue
    end

    desc 'finish_release', 'foo'
    def finish_release
      release_branch_name = 'release/1.0.0'

      queue = CommandQueue.new
      queue.add Git.checkout(branch_name: release_branch_name)
      queue.add Git.push(remote: 'origin', branch_name: release_branch_name)

      queue.list_queue
    end

    desc 'merge_release', 'foo'
    def merge_release
      release_branch_name = 'release/1.0.0'
      tag_name = '1.0.0'

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
