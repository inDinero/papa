require 'date'

module Papa
  module Helper
    class Helper::Output
      REDIRECT_TO_NULL = '> /dev/null 2>&1'

      def self.stdout(message, options = {})
        puts build_output(message)
      end

      def self.stderr(message, options = {})
        STDERR.puts build_output(message)
      end

      def self.error(message)
        stderr("ERROR: #{message}")
      end

      def self.success(message)
        puts
        puts message.strip.green
      end

      def self.failure(message)
        STDERR.puts
        STDERR.puts message.strip.red
      end

      def self.failure_reason(messages)
        messages.each do |message|
          STDERR.puts "  #{message}"
        end
      end

      def self.build_output(message)
        "[#{timestamp}] - #{message}"
      end

      def self.timestamp
        DateTime.now.strftime('%H:%M:%S')
      end
    end
  end
end
