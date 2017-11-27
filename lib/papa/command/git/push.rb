require 'papa/command/base'

module Papa
  module Command
    module Git
      class Push < Command::Base
        def initialize(remote, branch_name)
          command = "git push #{remote} #{branch_name}"
          super(command)
        end
      end
    end
  end
end
