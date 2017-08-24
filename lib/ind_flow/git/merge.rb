module IndFlow
  class Git::Merge < Command
    def initialize(branch_name)
      @branch_name = branch_name
      command = "git merge #{@branch_name} --no-ff"
      super(command)
    end

    def run
      current_branch # Store current branch before executing command
      super
    end

    def cleanup
      super
      queue = CommandQueue.new(suppress_output: true)
      queue.add Git.merge_abort
      queue.add Git.checkout(branch_name: current_branch)
      queue.run
    end

    def display_error_message
      super
      puts "ERROR: A merge conflict occurred while merging #{@branch_name} into #{current_branch}"
    end
  end
end
