require 'papa/helpers/path'

module Papa
  module Task
    module Sandbox
      class Clean
        attr_accessor :options

        def initialize(options = {})
          @options = options
        end

        def run
          Output.stdout('Started cleaning sandbox directories...') unless options[:silent]
          Command.new("rm -rf #{Helpers::Path::SANDBOX_PREFIX}*").run
          Output.success('Successfully removed sandbox directories.')
        end
      end
    end
  end
end
