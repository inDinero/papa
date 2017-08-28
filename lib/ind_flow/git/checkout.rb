module IndFlow
  class Git::Checkout < Command
    def initialize(branch_name)
      @branch_name = branch_name
      command = "git checkout #{@branch_name}"
      super(command)
    end

    def display_error_message
      super
      Output.stderr "ERROR: Branch #{@branch_name} doesn't exist."
    end
  end
end
