module Papa
  module CLI
    class Integration < Thor
      desc 'start', 'Start an integration branch'
      option :base_branch, aliases: ['-b', '-f'], required: true
      option :override_branch_name
      def start
        base_branch = options[:base_branch]
        task_options = { override_branch_name: options[:override_branch_name] }

        require 'papa/task/integration/start'
        Task::Integration::Start.new(base_branch, task_options).run
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

      desc 'deploy', 'Deploy the integration branch to SUBDOMAIN.indinerocorp.com'
      option :version, aliases: '-v', required: true
      option :subdomain, aliases: '-s'
      def deploy
        version = options[:version]
        # Renamed to subdomain because `-h` is already assigned to `papa integration help`.
        # Will still be referred to as `hostname` from here onwards.
        hostname = options[:subdomain]

        require 'papa/task/integration/deploy'
        Task::Integration::Deploy.new(version, hostname).run
      end
    end
  end
end
