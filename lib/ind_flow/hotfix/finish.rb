module IndFlow
  class Hotfix::Finish < Common::Finish
    def initialize(version:)
      @build_type = 'hotfix'
      @version = version
    end
  end
end
