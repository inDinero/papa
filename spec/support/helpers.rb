require 'ind_flow/command'

module Helpers
  def ind_flow(command)
    base_command = "ruby -I #{PROJECT_ROOT}/lib #{PROJECT_ROOT}/exe/ind_flow"
    IndFlow::Command.new("#{base_command} #{command}").run
  end
end
