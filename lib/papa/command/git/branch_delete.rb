require 'papa/command/base'

module Papa
  module Command
    module Git
      class BranchDelete < Command::Base
        def initialize(branch_name)
          @branch_name = branch_name
          command = "git branch -D #{branch_name}"
          super(command)
        end
      end
    end
  end
end
