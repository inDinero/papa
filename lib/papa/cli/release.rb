module Papa
  module CLI
    class Release < Thor
      desc 'start', 'Start a new release branch'
      option :version, aliases: '-v', required: true
      def start
        version = options[:version]

        require 'papa/task/release/start'
        Release::Start.new(version: version).run
      end

      desc 'add', 'Add feature branches to a release branch'
      option :version, aliases: '-v', required: true
      option :feature_branches, aliases: '-b', type: :array
      def add
        version = options[:version]
        feature_branches = options[:feature_branches] || []

        require 'papa/task/release/add'
        Release::Add.new(version: version, feature_branches: feature_branches).run
      end

      desc 'finish', 'Merge the release branch to master and develop'
      option :version, aliases: '-v', required: true
      def finish
        version = options[:version]

        require 'papa/task/release/finish'
        Release::Finish.new(version: version).run
      end
    end
  end
end
