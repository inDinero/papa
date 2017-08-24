module IndFlow
  class Git::Merge < Command
    def initialize(branch_name)
      @branch_name = branch_name
      command = "git merge #{@branch_name} --no-ff"
      super(command)
      current_branch # Just to store the current branch before executing
    end

    def cleanup
      super
      queue = CommandQueue.new
      queue.add Git.merge_abort
      queue.add Git.checkout(branch_name: current_branch)
      queue.run(skip_confirmation: true)
    end

    def display_error_message
      super
      puts "ERROR: A merge conflict occurred while merging #{@branch_name} into #{current_branch}"
    end
  end
end
