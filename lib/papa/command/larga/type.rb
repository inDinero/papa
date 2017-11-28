require 'papa/command/base'

module Papa
  module Command
    module Larga
      class Type < Command::Base
        def initialize
          command = 'type larga'
          super(command)
        end

        def failure_message
          super
          Helper::Output.stderr 'Larga is not installed in this system'
        end
      end
    end
  end
end
