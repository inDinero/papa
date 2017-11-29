require 'papa/command/base'

module Papa
  module Command
    module Git
      class PushForce < Command::Base
        def initialize(remote, branch_name)
          command = "git push #{remote} #{branch_name} --force-with-lease"
          super(command)
        end
      end
    end
  end
end
