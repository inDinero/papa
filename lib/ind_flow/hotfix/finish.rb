module IndFlow
  class Hotfix::Finish < Common::Finish
    def initialize(version:, additional_branches:)
      @build_type = 'hotfix'
      @version = version
      additional_branches ||= []
      @base_branches = ['develop', 'master'] + additional_branches
    end
  end
end
