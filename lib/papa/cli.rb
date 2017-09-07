require 'papa/common'
require 'papa/cli/release'
require 'papa/cli/hotfix'
require 'papa/cli/integration'
require 'papa/cli/deploy'
require 'papa/cli/sandbox'

module Papa
  class CLI < Thor
    desc 'release [COMMAND]', 'Perform actions on release branches'
    subcommand 'release', Release

    desc 'hotfix [COMMAND]', 'Perform actions on hotfix branches'
    subcommand 'hotfix', Hotfix

    desc 'integration [COMMAND]', 'Perform actions on integration branches'
    subcommand 'integration', Integration

    desc 'deploy', 'Deploy a branch with larga'
    option :branch, aliases: '-b', required: true
    def deploy
      branch = options[:branch]

      Deploy.new(branch: branch).run
    end

    desc 'sandbox [COMMAND]', 'Test out papa in a sandboxed git environment'
    subcommand 'sandbox', Sandbox
  end
end
