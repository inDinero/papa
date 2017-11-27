require 'papa/command/base'

module Papa
  module Command
    module Git
      class Branch < Command::Base
        def initialize(branch_name)
          @branch_name = branch_name
          command = "git branch #{branch_name}"
          super(command)
        end
      end
    end
  end
end
