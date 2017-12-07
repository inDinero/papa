require 'papa/task/common/add'

module Papa
  module Task
    module Integration
      class Add < Common::Add
        def initialize(version:, branches:)
          @build_type = 'integration'
          @version = version
          @branches = branches
        end
      end
    end
  end
end
