require 'papa/common'
require 'papa/release'
require 'papa/hotfix'
require 'papa/sandbox'

module Papa
  class CLI < Thor
    desc 'release [COMMAND]', 'Perform actions on release branches'
    subcommand 'release', Release

    desc 'hotfix [COMMAND]', 'Perform actions on hotfix branches'
    subcommand 'hotfix', Hotfix

    desc 'sandbox [COMMAND]', 'Test out papa in a sandboxed git environment'
    subcommand 'sandbox', Sandbox
  end
end
