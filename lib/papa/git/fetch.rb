module Papa
  class Git::Fetch < Command
    def initialize(remote)
      command = "git fetch #{remote}"
      super(command)
    end

    def failure_message
      super
      Output.stderr 'ERROR: Make sure origin exists and you have a working Internet connection'
    end
  end
end
