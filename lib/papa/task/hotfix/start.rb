require 'papa/task/common/start'

module Papa
  module Task
    module Hotfix
      class Start < Common::Start
        def initialize(version)
          @build_type = 'hotfix'
          @base_branch = 'master'
          @version = version
          super()
        end
      end
    end
  end
end
