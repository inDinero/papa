module IndFlow
  class Commander
    def self.send_command(command)
      output = `#{command}`
      exit_status = $?.exitstatus
      {
        output: output,
        exit_status: exit_status
      }
    end
  end
end
