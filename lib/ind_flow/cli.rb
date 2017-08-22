require 'ind_flow/release'

module IndFlow
  class CLI < Thor
    desc 'release [COMMAND]', 'foo'
    subcommand 'release', Release
  end
end
