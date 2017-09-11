module Papa
  class Command
    attr_accessor :command, :output, :exit_status

    def initialize(command, options = {})
      @command = command
      @output = nil
      @exit_status = nil
      @output_redirect =
        if options[:silent]
          Output::REDIRECT_TO_NULL
        else
          ''
        end
    end

    def run
      return if @command.nil?
      output = `#{@command} #{@output_redirect}`
      exit_status = $?.exitstatus
      @output = output
      @exit_status = exit_status
      self
    end

    def failure_message
      Output.stderr "ERROR: There was a problem running '#{command}'"
    end

    def cleanup
      # Override me
    end

    def success?
      !failed?
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
