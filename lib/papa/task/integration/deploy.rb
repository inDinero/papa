require 'papa/task/common/deploy'

module Papa
  module Task
    module Integration
      class Deploy < Common::Deploy
        def initialize(version)
          @build_type = 'integration'
          @version = version
          @hostname = 'integration'
          super()
        end
      end
    end
  end
end
