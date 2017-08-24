module IndFlow
  class Release::Merge < Common::Merge
    def initialize(version:)
      @build_type = 'release'
      @version = version
      @base_branches = ['develop', 'master']
    end
  end
end
