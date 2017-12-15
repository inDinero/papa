require 'papa/task/base'
require 'papa/command/larga/type'
require 'papa/command/larga/deploy'

module Papa
  module Task
    module Common
      class Deploy < Base
        def initialize
          check_if_build_branch_exists
        end

        private

        def queue
          [
            Command::Larga::Type.new,
            Command::Larga::Deploy.new(deploy_options)
          ]
        end

        def deploy_options
          {
            branch: build_branch,
            hostname: @hostname
          }
        end

        def success_message
          Helper::Output.success 'Successfully deployed larga instance.'
          info = ''
          info << "  Branch: #{build_branch}\n"
          info << "  URL: https://#{@hostname}.indinerocorp.com\n"
          Helper::Output.success_info info
        end

        def failure_message
          Helper::Output.failure 'There was a problem deploying larga instance.'
          info = ''
          info << "  Branch: #{build_branch}\n"
          Helper::Output.failure_info info
        end
      end
    end
  end
end
