module IndFlow
  class Command
    attr_accessor :command, :output, :exit_status

    def initialize(command)
      @command = command
      @output = nil
      @exit_status = nil
    end

    def run
      return if @command.nil?
      puts "DEBUG: Running command **#{@command}**..."
      output = `#{@command}`
      exit_status = $?.exitstatus
      puts "DEBUG: Command **#{@command}** returned #{exit_status}."
      @output = output
      @exit_status = exit_status
      self
    end

    def is_nonzero_exit_status?
      @exit_status != 0
    end
  end
end
