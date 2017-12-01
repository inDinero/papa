require 'papa/cli/release'
require 'papa/cli/hotfix'
require 'papa/cli/integration'
require 'papa/cli/sandbox'

module Papa
  module CLI
    class Main < Thor
      desc 'release [COMMAND]', 'Perform actions on release branches'
      subcommand 'release', CLI::Release

      desc 'hotfix [COMMAND]', 'Perform actions on hotfix branches'
      subcommand 'hotfix', CLI::Hotfix

      desc 'integration [COMMAND]', 'Perform actions on integration branches'
      subcommand 'integration', CLI::Integration

      desc 'sandbox [COMMAND]', 'Test out papa in a sandboxed git environment'
      subcommand 'sandbox', CLI::Sandbox
    end
  end
end
