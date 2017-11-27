require 'papa/command/base'

module Papa
  module Command
    module Git
      class Pull < Command::Base
        def initialize(remote, branch_name)
          command = "git pull #{remote} #{branch_name}"
          super(command)
        end
      end
    end
  end
end
