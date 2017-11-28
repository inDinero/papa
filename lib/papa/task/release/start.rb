require 'papa/task/common/start'

module Papa
  module Task
    module Release
      class Start < Common::Start
        def initialize(version:)
          @build_type = 'release'
          @base_branch = 'develop'
          @version = version
        end
      end
    end
  end
end
