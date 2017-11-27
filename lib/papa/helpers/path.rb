require 'securerandom'

module Papa
  module Helpers
    class Path
      TMP_PATH = '/tmp/'
      VI_PREFIX = 'papa-vi-'
      SANDBOX_PREFIX = 'papa-sandbox-'

      def self.generate_vi_file_path
        File.join(TMP_PATH, VI_PREFIX + uuid_gen + '.txt')
      end

      def self.generate_sandbox_path(type, options = {})
        path =
          if options.has_key?('override_path_prefix')
            options[:override_path_prefix] + '-' + type
          else
            SANDBOX_PREFIX + type + '-' +  uuid_gen
          end
        File.join(TMP_PATH, path)
      end

      def self.uuid_gen
        SecureRandom.uuid
      end
    end
  end
end
