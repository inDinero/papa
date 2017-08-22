module IndFlow
  class Release < Thor
    desc 'start', 'foo'
    def start
      version = '1.0.0'

      require 'ind_flow/release/start'
      Release::Start.new(version: version).run
    end

    desc 'add', 'foo'
    def add
      version = '1.0.0'
      feature_branches = [
        'feature/1-add-foobars',
        'feature/2-make-foobars',
        'feature/3-eat-foobars'
      ]

      require 'ind_flow/release/add'
      Release::Add.new(version: version, feature_branches: feature_branches).run
    end

    desc 'finish', 'foo'
    def finish
      version = '1.0.0'

      require 'ind_flow/release/finish'
      Release::Finish.new(version: version).run
    end

    desc 'merge', 'foo'
    def merge
      version = '1.0.0'

      require 'ind_flow/release/merge'
      Release::Merge.new(version: version).run
    end
  end
end
