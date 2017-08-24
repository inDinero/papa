require 'ind_flow/common'
require 'ind_flow/release'
require 'ind_flow/hotfix'
require 'ind_flow/sandbox'

module IndFlow
  class CLI < Thor
    desc 'release [COMMAND]', 'foo'
    subcommand 'release', Release

    desc 'hotfix [COMMAND]', 'foo'
    subcommand 'hotfix', Hotfix

    desc 'sandbox [COMMAND]', 'foo'
    subcommand 'sandbox', Sandbox
  end
end
