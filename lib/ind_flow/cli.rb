require 'ind_flow/common'
require 'ind_flow/release'
require 'ind_flow/hotfix'

module IndFlow
  class CLI < Thor
    desc 'release [COMMAND]', 'foo'
    subcommand 'release', Release

    desc 'hotfix [COMMAND]', 'foo'
    subcommand 'hotfix', Hotfix
  end
end
