module Papa
  module Helper
    class Logger
      def self.log(message)
        File.open(log_path, 'a+') do |file|
          file.puts message
        end
      end

      def self.log_path
        return @log_path if defined?(@log_path)
        command = ARGV.first(2).join('_')
        timestamp = Time.now.strftime('%Y_%m_%d_%I_%M_%S')
        @log_path = ['papa', command, timestamp].join('_') + '.log'
      end
    end
  end
end
