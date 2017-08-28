module IndFlow
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

    def display_error_message
      super
      Output.stderr "ERROR: There was a problem rebasing #{current_branch} from #{@base_branch_name}"
    end
  end
end
