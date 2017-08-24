module IndFlow
  class Command
    attr_accessor :command, :output, :exit_status

    def initialize(command, options = {})
      @command = command
      @suppress_output = true
      @output = nil
      @exit_status = nil
    end

    def run
      return if @command.nil?
      # puts "DEBUG: Running '#{@command}'..."
      command =
        if @suppress_output
          @command + '> /dev/null 2>&1'
        else
          @command
        end
      output = `#{command}`
      exit_status = $?.exitstatus
      # puts "DEBUG: '#{@command}' returned #{exit_status}."
      @output = output
      @exit_status = exit_status
      self
    end

    def display_error_message
      puts "ERROR: There was a problem running '#{command}'"
    end

    def cleanup
      puts 'Cleaning up...'
    end

    def success?
      @exit_status == 0
    end

    def failed?
      @exit_status != 0
    end

    private

    def current_branch
      @current_branch ||= `git symbolic-ref --short HEAD`.chomp
    end
  end
end
