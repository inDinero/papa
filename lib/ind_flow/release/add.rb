module IndFlow
  class Release::Add < Common::Add
    def initialize(version:, feature_branches:)
      @build_type = "release"
      @version = version
      @branches = feature_branches
    end
  end
end
