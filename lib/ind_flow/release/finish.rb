module IndFlow
  class Release::Finish < Common::Finish
    def initialize(version:)
      @build_type = 'release'
      @version = version
      @tag_name = version
      @base_branches = ['develop', 'master']
    end
  end
end
