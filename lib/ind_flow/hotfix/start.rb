module IndFlow
  class Hotfix::Start < Common::Start
    def initialize(version:)
      @build_type = 'hotfix'
      @base_branch = 'master'
      @version = version
    end
  end
end
