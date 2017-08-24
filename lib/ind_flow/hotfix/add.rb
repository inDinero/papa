module IndFlow
  class Hotfix::Add < Common::Add
    def initialize(version:, bugfix_branches:)
      @build_type = 'hotfix'
      @version = version
      @branches = bugfix_branches
    end
  end
end
