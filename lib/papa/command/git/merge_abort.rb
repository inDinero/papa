require 'papa/command/base'

module Papa
  module Command
    module Git
      class MergeAbort < Command::Base
        def initialize
          command = 'git merge --abort'
          super(command)
        end
      end
    end
  end
end
