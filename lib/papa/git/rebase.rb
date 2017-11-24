module Papa
  class Git::Rebase < Command
    def initialize(base_branch_name)
      @base_branch_name = base_branch_name
      command = "git rebase #{@base_branch_name}"
      super(command)
    end

    def run
      current_branch # Store current branch before executing command
      super
    end

    def cleanup
      super
      queue = CommandQueue.new
      queue.add Git.rebase_abort
      queue.add Git.checkout(branch_name: current_branch)
      queue.run
    end

    def failure_message
      super
      message = "Failed to rebase #{current_branch} from #{@base_branch_name}. Merge conflict?"
      Output.error message
      message
    end
  end
end
