require 'papa/command/base'

module Papa
  module Command
    module Git
      class Fetch < Command::Base
        def initialize(remote)
          @remote = remote
          command = "git fetch #{remote}"
          super(command)
        end

        def failure_message
          super
          message = "Failed to fetch from #{@remote}. Please check your internet connection and try again."
          Output.stderr message
          message
        end
      end
    end
  end
end
