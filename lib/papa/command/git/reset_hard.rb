require 'papa/command/base'

module Papa
  module Command
    module Git
      class ResetHard < Command::Base
        def initialize(remote, branch_name)
          command = "git reset --hard #{remote}/#{branch_name}"
          super(command)
        end
      end
    end
  end
end
