require 'yaml'
require 'papa/helper/output'

module Papa
  module Helper
    class Config
      def self.read
        return @config if defined?(@config)
        exit_on_config_not_exists unless config_exists?
        @config = YAML.load_file(config_path)
      end

      def self.config_path
        "#{Dir.home}/.papa.config.yml"
      end

      def self.config_exists?
        File.exists?(config_path)
      end

      def self.exit_on_config_not_exists
        message = 'Cannot find config file.'
        Helper::Output.failure message
        info = <<-INFO
Make sure you have a valid config file in #{config_path}.
See README.md for more details.
        INFO
        Helper::Output.failure_info info
        exit 1
      end
    end
  end
end
