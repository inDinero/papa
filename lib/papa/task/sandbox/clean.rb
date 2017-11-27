require 'papa/helper/path'

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
          Command.new("rm -rf #{Helper::Path::SANDBOX_PREFIX}*").run
          Helper::Output.success('Successfully removed sandbox directories.')
        end
      end
    end
  end
end
