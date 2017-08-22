module IndFlow
  class CLI < Thor
    desc 'start_release', 'foo'
    def start_release
      version = '1.0.0'

      require 'ind_flow/cli/start_release'
      CLI::StartRelease.new(version: version).run
    end

    desc 'add_to_release', 'foo'
    def add_to_release
      version = '1.0.0'
      feature_branches = [
        'feature/1-add-foobars',
        'feature/2-make-foobars',
        'feature/3-eat-foobars'
      ]

      require 'ind_flow/cli/add_to_release'
      CLI::AddToRelease.new(version: version, feature_branches: feature_branches).run
    end

    desc 'finish_release', 'foo'
    def finish_release
      version = '1.0.0'

      require 'ind_flow/cli/finish_release'
      CLI::FinishRelease.new(version: version).run
    end

    desc 'merge_release', 'foo'
    def merge_release
      version = '1.0.0'

      require 'ind_flow/cli/merge_release'
      CLI::MergeRelease.new(version: version).run
    end
  end
end
