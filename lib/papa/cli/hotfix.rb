module Papa
  module CLI
    class Hotfix < Thor
      desc 'start', 'Start a new hotfix branch'
      option :version, aliases: '-v', required: true
      def start
        version = options[:version]

        require 'papa/task/hotfix/start'
        Task::Hotfix::Start.new(version).run
      end

      desc 'add', 'Add bugfix branches to a hotfix branch'
      option :version, aliases: '-v', required: true
      option :bugfix_branches, aliases: '-b', type: :array
      def add
        version = options[:version]
        bugfix_branches = options[:bugfix_branches] || []

        require 'papa/task/hotfix/add'
        Task::Hotfix::Add.new(version, bugfix_branches).run
      end

      desc 'deploy', 'Deploy the hotfix branch to hotfix.indinerocorp.com'
      option :version, aliases: '-v', required: true
      def deploy
        version = options[:version]
        require 'papa/task/hotfix/deploy'
        Task::Hotfix::Deploy.new(version).run
      end

      desc 'finish', 'Merge the hotfix branch to the base branches'
      option :version, aliases: '-v', required: true
      option :additional_branches, aliases: '-b', type: :array
      def finish
        version = options[:version]
        additional_branches = options[:additional_branches]

        require 'papa/task/hotfix/finish'
        Task::Hotfix::Finish.new(version, additional_branches).run
      end
    end
  end
end
