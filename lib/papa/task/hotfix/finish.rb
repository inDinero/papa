require 'papa/task/common/finish'

module Papa
  module Task
    module Hotfix
      class Finish < Common::Finish
        def initialize(version, additional_branches)
          @build_type = 'hotfix'
          @version = version
          additional_branches ||= []
          @tag_name = version
          @base_branches = ['develop', 'master'] + additional_branches
          super()
        end
      end
    end
  end
end
