require 'open3'

module Papa
  class Command
    attr_accessor :command, :stdout, :stderr, :exit_status

    def initialize(command, options = {})
      @command = command
      @stdout = nil
      @stderr = nil
      @exit_status = nil
      @output_redirect =
        if options[:silent]
          ''
        else
          Output::REDIRECT_TO_NULL
        end
    end

    def run
      return if @command.nil?
      Output.stdout "Running #{@command.bold}..."
      stdout, stderr, exit_status = Open3.capture3(@command)
      @stdout = stdout
      @stderr = stderr
      @exit_status = exit_status
      self
    end

    def failure_message
      message = "There was a problem running #{command.bold}."
      Output.stderr "ERROR: #{message}"
      message
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
