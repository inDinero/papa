require 'papa/task/common/add'

module Papa
  module Task
    module Release
      class Add < Common::Add
        def initialize(version:, feature_branches:)
          @build_type = "release"
          @version = version
          @branches = feature_branches
        end
      end
    end
  end
end
