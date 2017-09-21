require 'open3'
require 'pry'
require 'pry-byebug'

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
      return if command.nil?
      Output.stdout "Running #{command.bold}..."
      @stdout, @stderr, status = Open3.capture3(command)
      @exit_status = status.exitstatus
      self
    end

    def failure_message
      message = "Error while running #{command.bold}"
      Output.error message
      Output.error stderr
      message
    end

    def cleanup
      # Override me
    end

    def success?
      !failed?
    end

    def failed?
      exit_status != 0
    end

    private

    def current_branch
      @current_branch ||= `git symbolic-ref --short HEAD`.chomp
    end
  end
end
