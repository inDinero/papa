module Papa
  module CLI
    class Main < Thor
      desc 'release [COMMAND]', 'Perform actions on release branches'
      subcommand 'release', CLI::Release

      desc 'hotfix [COMMAND]', 'Perform actions on hotfix branches'
      subcommand 'hotfix', CLI::Hotfix

      desc 'integration [COMMAND]', 'Perform actions on integration branches'
      subcommand 'integration', CLI::Integration

      desc 'deploy', 'Deploy a branch with larga'
      option :branch, aliases: '-b', required: true
      option :hostname, aliases: '-h'
      def deploy
        require 'papa/task/deploy'

        branch = options[:branch]
        hostname = options[:hostname]

        Task::Deploy.new(branch: branch, hostname: hostname).run
      end

      desc 'sandbox [COMMAND]', 'Test out papa in a sandboxed git environment'
      subcommand 'sandbox', CLI::Sandbox
    end
  end
end
