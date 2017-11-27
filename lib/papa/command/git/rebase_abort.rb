require 'papa/command/base'

module Papa
  module Command
    module Git
      class RebaseAbort < Command::Base
        def initialize
          command = 'git rebase --abort'
          super(command)
        end
      end
    end
  end
end
