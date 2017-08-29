require 'papa/command'

module Helpers
  def papa(command)
    base_command = "ruby -I #{PROJECT_ROOT}/lib #{PROJECT_ROOT}/exe/papa"
    stdout, stderr, exit_status = Open3.capture3("#{base_command} #{command}")
    {
      stdout: stdout,
      stderr: stderr,
      exit_status: exit_status.exitstatus
    }
  end
end
