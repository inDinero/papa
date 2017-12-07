require 'papa/task/common/add'

module Papa
  module Task
    module Hotfix
      class Add < Common::Add
        def initialize(version, bugfix_branches)
          @build_type = 'hotfix'
          @version = version
          @branches = bugfix_branches
        end
      end
    end
  end
end
