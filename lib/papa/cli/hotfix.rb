module Papa
  module CLI
    class Hotfix < Thor
      desc 'start', 'Start a new hotfix branch'
      option :version, aliases: '-v', required: true
      def start
        version = options[:version]

        require 'papa/common/start'
        require 'papa/hotfix/start'
        Hotfix::Start.new(version: version).run
      end

      desc 'add', 'Add bugfix branches to a hotfix branch'
      option :version, aliases: '-v', required: true
      option :bugfix_branches, aliases: '-b', type: :array
      def add
        version = options[:version]
        bugfix_branches = options[:bugfix_branches] || []

        require 'papa/common/add'
        require 'papa/hotfix/add'
        Hotfix::Add.new(version: version, bugfix_branches: bugfix_branches).run
      end

      desc 'finish', 'Merge the hotfix branch to the base branches'
      option :version, aliases: '-v', required: true
      option :additional_branches, aliases: '-b', type: :array
      def finish
        version = options[:version]
        additional_branches = options[:additional_branches]

        require 'papa/common/finish'
        require 'papa/hotfix/finish'
        Hotfix::Finish.new(version: version, additional_branches: additional_branches).run
      end
    end
  end
end
