module IndFlow
  class Hotfix < Thor
    desc 'start', 'Start a new hotfix branch'
    option :version, aliases: '-v', required: true
    def start
      version = options[:version]
      require 'ind_flow/hotfix/start'
      Hotfix::Start.new(version: version).run
    end

    desc 'add', 'Add bugfix branches to a hotfix branch'
    option :version, aliases: '-v', required: true
    option :bugfix_branches, aliases: '-b', type: :array, required: true
    def add
      version = options[:version]
      bugfix_branches = options[:bugfix_branches]

      require 'ind_flow/common/add'
      require 'ind_flow/hotfix/add'
      Hotfix::Add.new(version: version, bugfix_branches: bugfix_branches).run
    end

    desc 'finish', 'Finish a hotfix branch'
    option :version, aliases: '-v', required: true
    def finish
      version = options[:version]

      require 'ind_flow/hotfix/finish'
      Hotfix::Finish.new(version: version).run
    end

    desc 'merge', 'Merge the hotfix branch to the base branches'
    option :version, aliases: '-v', required: true
    option :additional_branches, aliases: '-b', type: :array
    def merge
      version = options[:version]
      additional_branches = options[:additional_branches]

      require 'ind_flow/hotfix/merge'
      Hotfix::Merge.new(version: version, additional_branches: additional_branches).run
    end
  end
end
