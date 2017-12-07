module Papa
  module CLI
    class Integration < Thor
      desc 'start', 'Start an integration branch'
      option :base_branch, aliases: '-b', required: true
      def start
        base_branch = options[:base_branch]
        hostname = options[:hostname]

        require 'papa/task/integration/start'
        Task::Integration::Start.new(base_branch: base_branch).run
      end

      desc 'add', 'Add branches to a integration branch'
      option :version, aliases: '-v', required: true
      option :branches, aliases: '-b', type: :array
      def add
        version = options[:version]
        branches = options[:branches] || []

        require 'papa/task/integration/add'
        Task::Integration::Add.new(version, branches).run
      end

      desc 'deploy', 'Deploy the integration branch to integration.indinerocorp.com'
      option :version, aliases: '-v', required: true
      def deploy
        version = options[:version]

        require 'papa/task/integration/deploy'
        Task::Integration::Deploy.new(version: version).run
      end
    end
  end
end
