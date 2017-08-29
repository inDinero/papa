module Papa
  class Command
    attr_accessor :command, :output, :exit_status

    def initialize(command)
      @command = command
      @output = nil
      @exit_status = nil
    end

    def run
      return if @command.nil?
      output = `#{@command} #{Output::REDIRECT_TO_NULL}`
      exit_status = $?.exitstatus
      @output = output
      @exit_status = exit_status
      self
    end

    def failure_message
      Output.stderr "ERROR: There was a problem running '#{command}'"
    end

    def cleanup
      Output.stderr 'Cleaning up...'
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
