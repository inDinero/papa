require 'papa/task/common/finish'

module Papa
  module Task
    module Release
      class Finish < Common::Finish
        def initialize(version:)
          @build_type = 'release'
          @version = version
          @tag_name = version
          @base_branches = ['develop', 'master']
        end
      end
    end
  end
end
