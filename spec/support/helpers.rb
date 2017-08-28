require 'ind_flow/command'

module Helpers
  def ind_flow(command)
    base_command = "ruby -I #{PROJECT_ROOT}/lib #{PROJECT_ROOT}/exe/ind_flow"
    stdout, stderr, exit_status = Open3.capture3("#{base_command} #{command}")
    {
      stdout: stdout,
      stderr: stderr,
      exit_status: exit_status.exitstatus
    }
  end
end
