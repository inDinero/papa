require 'papa/helper/logger'

module Papa
  module Helper
    class Output
      REDIRECT_TO_NULL = '> /dev/null 2>&1'

      def self.stdout(message, options = {})
        message = build_output(message)
        puts message
        Helper::Logger.log(message)
      end

      def self.stderr(message, options = {})
        message = build_output(message)
        STDERR.puts message
        Helper::Logger.log(message)
      end

      def self.error(message)
        message = "ERROR: #{message}"
        stderr(message)
        Helper::Logger.log(message)
      end

      def self.success(message)
        message.strip!
        puts
        puts message.green
        Helper::Logger.log(message)
      end

      def self.failure(message)
        message.strip!
        STDERR.puts
        STDERR.puts message.red
        Helper::Logger.log(message)
      end

      def self.success_info(message)
        puts message
        Helper::Logger.log(message)
      end

      def self.failure_info(message)
        STDERR.puts message
        Helper::Logger.log(message)
      end

      def self.build_output(message)
        "[#{timestamp}] - #{message}"
      end

      def self.timestamp
        Time.now.strftime('%I:%M:%S %p')
      end
    end
  end
end
