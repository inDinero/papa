module IndFlow
  class Release < Thor
    desc 'start', 'Start a new release branch'
    option :version, aliases: '-v', required: true
    def start
      version = options[:version]
      require 'ind_flow/release/start'
      Release::Start.new(version: version).run
    end

    desc 'add', 'Add feature branches to a release branch'
    option :version, aliases: '-v', required: true
    option :feature_branches, aliases: '-b', type: :array, required: true
    def add
      version = options[:version]
      feature_branches = options[:feature_branches]

      require 'ind_flow/common/add'
      require 'ind_flow/release/add'
      Release::Add.new(version: version, feature_branches: feature_branches).run
    end

    desc 'finish', 'Finish a release branch'
    option :version, aliases: '-v', required: true
    def finish
      version = options[:version]

      require 'ind_flow/release/finish'
      Release::Finish.new(version: version).run
    end

    desc 'merge', 'Merge the release branch to the base branches'
    option :version, aliases: '-v', required: true
    def merge
      version = options[:version]

      require 'ind_flow/release/merge'
      Release::Merge.new(version: version).run
    end
  end
end
