module Papa
  class Release < Thor
    desc 'start', 'Start a new release branch'
    option :version, aliases: '-v', required: true
    def start
      version = options[:version]

      require 'papa/common/start'
      require 'papa/release/start'
      Release::Start.new(version: version).run
    end

    desc 'add', 'Add feature branches to a release branch'
    option :version, aliases: '-v', required: true
    option :feature_branches, aliases: '-b', type: :array, required: true
    def add
      version = options[:version]
      feature_branches = options[:feature_branches]

      require 'papa/common/add'
      require 'papa/release/add'
      Release::Add.new(version: version, feature_branches: feature_branches).run
    end

    desc 'finish', 'Merge the release branch to master and develop'
    option :version, aliases: '-v', required: true
    def finish
      version = options[:version]

      require 'papa/common/finish'
      require 'papa/release/finish'
      Release::Finish.new(version: version).run
    end

    # desc 'patch', 'Add a patch to release branch'
    # option :version, aliases: '-v', required: true
    # option :patch_branch, aliases: '-b', required: true
    # def patch 
    #   version = options[:version]
    #   patch_branch = options[:patch_branch]
    #
    #   require 'papa/common/add'
    #   require 'papa/release/patch'
    #   Release::Patch.new(version: version, patch_branch: patch_branch).run
    # end
  end
end
