require 'papa/command/larga/type'
require 'papa/command/larga/deploy'
require 'papa/runner'

module Papa
  module Task
    class Deploy
      def initialize(options = {})
        @options = options
      end

      def run
        queue = [
          Command::Larga::Type.new,
          Command::Larga::Deploy.new(@options)
        ]
        runner = Runner.new(queue)

        if runner.run
          success_message
        else
          failure_message
          exit 1
        end
      end

      private

      def success_message
        Helper::Output.success 'Successfully deployed larga instance.'
      end

      def failure_message
        Helper::Output.failure 'There was a problem deploying larga instance.'
      end
    end
  end
end
