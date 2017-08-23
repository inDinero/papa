module IndFlow
  class Hotfix::Merge
    def initialize(version:, additional_branches:)
      @version = version
      @additional_branches = additional_branches || []
    end

    def run
      hotfix_branch_name = "hotfix/#{@version}"
      tag_name = @version

      queue = CommandQueue.new

      # Merge to develop
      queue.add Git.checkout(branch_name: 'develop')
      queue.add Git.merge(branch_name: hotfix_branch_name)
      queue.add Git.push(remote: 'origin', branch_name: 'develop')

      # Merge to master
      queue.add Git.checkout(branch_name: 'master')
      queue.add Git.merge(branch_name: hotfix_branch_name)
      queue.add Git.push(remote: 'origin', branch_name: 'master')
      queue.add Git.tag(tag_name: tag_name)
      queue.add Git.push_tag(remote: 'origin', tag_name: tag_name)

      # Merge to additional branches
      @additional_branches.each do |additional_branch|
        queue.add Git.checkout(branch_name: additional_branch)
        queue.add Git.merge(branch_name: hotfix_branch_name)
        queue.add Git.push(remote: 'origin', branch_name: additional_branch)
      end

      queue.list_queue
    end
  end
end
