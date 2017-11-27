require 'papa/command/base'

module Papa
  module Command
    module Larga
      class Type < Command
        def initialize
          super('type larga')
        end

        def failure_message
          super
          Output.stderr 'Larga is not installed in this system'
        end
      end
    end
  end
end
