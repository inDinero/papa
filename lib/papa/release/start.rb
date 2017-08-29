module Papa
  class Release::Start < Common::Start
    def initialize(version:)
      @build_type = 'release'
      @base_branch = 'develop'
      @version = version
    end
  end
end
