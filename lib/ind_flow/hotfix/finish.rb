module IndFlow
  class Hotfix::Merge < Common::Merge
    def initialize(version:, additional_branches:)
      @build_type = 'hotfix'
      @version = version
      additional_branches ||= []
      @base_branches = ['develop', 'master'] + additional_branches
    end
  end
end
