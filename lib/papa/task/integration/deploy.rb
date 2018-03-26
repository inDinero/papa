require 'papa/task/common/deploy'

module Papa
  module Task
    module Integration
      class Deploy < Common::Deploy
        def initialize(version, hostname)
          @build_type = 'integration'
          @version = version
          @hostname = hostname || 'integration'
          super()
        end
      end
    end
  end
end
