module IndFlow
  class Git::Rebase < Command
    def initialize(base_branch_name)
      @base_branch_name = base_branch_name
      command = "git rebase #{@base_branch_name}"
      super(command)
      current_branch
    end

    def cleanup
      super
      @build_branch ||= 'develop'
      
      queue = CommandQueue.new
      queue.add Git.rebase_abort
      queue.add Git.checkout(branch_name: @build_branch)
      queue.run(skip_confirmation: true)
    end

    def display_error_message
      super
      puts "ERROR: There was a problem rebasing #{current_branch} from #{@base_branch_name}"
    end
  end
end
