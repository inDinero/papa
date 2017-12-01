require 'papa/task/common/start'
require 'papa/command/larga/type'
require 'papa/command/larga/deploy'
require 'date'

module Papa
  module Task
    module Integration
      class Start < Common::Start
        def initialize(base_branch:, hostname:)
          @build_type = 'integration'
          @base_branch = base_branch
          @hostname = hostname
          @build_branch = generate_integration_branch_name
        end

        def run
          super
          deploy_options = {
            branch: @build_branch,
            hostname: @hostname
          }
          queue = [
            Command::Larga::Type.new,
            Command::Larga::Deploy.new(deploy_options)
          ]
          runner = Runner.new(queue)

          if runner.run
            success_message_integration
          else
            failure_message_integration
            exit 1
          end
        end

        private

        def generate_integration_branch_name
          "integration/#{DateTime.now.strftime('%y.%m.%d.%H.%M').gsub('.0', '.')}"
        end

        def success_message_integration
          Helper::Output.success 'Successfully deployed larga instance.'
        end

        def failure_message_integration
          Helper::Output.failure 'There was a problem deploying larga instance.'
        end
      end
    end
  end
end
