require 'papa/task/common/deploy'

module Papa
  module Task
    module Hotfix
      class Deploy < Common::Deploy
        def initialize(version)
          @build_type = 'hotfix'
          @version = version
          @hostname = 'hotfix'
        end
      end
    end
  end
end
