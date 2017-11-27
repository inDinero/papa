module Papa
  class Runner
    attr_accessor :queue, :last_command, :success, :last_error

    def initialize
      @queue = []
    end

    def add(command)
      @queue.push command
    end

    def run
      @success = true
      message = nil
      @queue.each do |command|
        if command.run.failed?
          @success = false
          command.cleanup
          @last_error = command.failure_message
          break
        end
      end
      @success
    end
  end
end
