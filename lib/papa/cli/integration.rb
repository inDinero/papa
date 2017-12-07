module Papa
  module CLI
    class Integration < Thor
      desc 'start', 'Start an integration branch'
      option :base_branch, aliases: '-b', required: true
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

      desc 'deploy', 'Deploy the integration branch to integration.indinerocorp.com'
      option :version, aliases: '-v', required: true
      def deploy
        version = options[:version]

        require 'papa/task/integration/deploy'
        Task::Integration::Deploy.new(version).run
      end
    end
  end
end
