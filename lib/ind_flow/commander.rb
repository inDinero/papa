module IndFlow
  class Commander
    def self.send_command(command)
      puts "DEBUG: Running command **#{command}**..."
      output = `#{command}`
      exit_status = $?.exitstatus
      puts "DEBUG: Command **#{command}** returned #{exit_status}."
      {
        output: output,
        exit_status: exit_status
      }
    end
  end
end
