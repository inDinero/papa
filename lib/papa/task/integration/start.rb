require 'papa/task/common/start'
require 'papa/command/larga/type'
require 'papa/command/larga/deploy'
require 'date'

module Papa
  module Task
    module Integration
      class Start < Common::Start
        def initialize(base_branch, options = {})
          @build_type = 'integration'
          @base_branch = base_branch
          @build_branch = options[:override_branch_name] || generate_integration_branch_name
        end

        private

        def generate_integration_branch_name
          "integration/#{DateTime.now.strftime('%y.%m.%d.%H.%M.%S').gsub('.0', '.')}"
        end
      end
    end
  end
end
