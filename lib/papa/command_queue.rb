module Papa
  class CommandQueue
    attr_accessor :queue

    def initialize
      @queue = []
    end

    def add(command)
      @queue.push command
    end

    def list_queue
      Output.stdout 'Running:'
      @queue.each do |command|
        Output.stdout "  #{command.command}"
      end
    end

    def run
      success = true
      list_queue
      @queue.each do |command|
        if command.run.failed?
          success = false
          command.cleanup
          command.failure_message
          break
        end
      end
      success
    end
  end
end
