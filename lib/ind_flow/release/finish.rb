module IndFlow
  class Release::Finish < Common::Finish
    def initialize(version:)
      @build_type = 'release'
      @version = version
    end
  end
end
