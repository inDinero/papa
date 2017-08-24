require 'ind_flow/common'
require 'ind_flow/release'
require 'ind_flow/hotfix'
require 'ind_flow/sandbox'

module IndFlow
  class CLI < Thor
    desc 'release [COMMAND]', 'Perform actions on release branches'
    subcommand 'release', Release

    desc 'hotfix [COMMAND]', 'Perform actions on hotfix branches'
    subcommand 'hotfix', Hotfix

    desc 'sandbox [COMMAND]', 'Test out ind_flow in a sandboxed git environment'
    subcommand 'sandbox', Sandbox
  end
end
