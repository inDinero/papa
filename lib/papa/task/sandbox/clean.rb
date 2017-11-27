require 'papa/helper/path'
require 'papa/command/base'

module Papa
  module Task
    module Sandbox
      class Clean
        attr_accessor :options

        def initialize(options = {})
          @options = options
        end

        def run
          Helper::Output.stdout('Started cleaning sandbox directories...') unless options[:silent]
          path = File.join(Helper::Path::TMP_PATH, Helper::Path::SANDBOX_PREFIX)
          Command::Base.new("rm -rf #{path}*").run
          Helper::Output.success('Successfully removed sandbox directories.')
        end
      end
    end
  end
end
