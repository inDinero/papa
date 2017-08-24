module IndFlow
  class CommandQueue
    attr_accessor :queue

    def initialize(options = {})
      @suppress_output = options[:suppress_output]
      @queue = []
    end

    def add(command)
      @queue.push command
    end

    def list_queue
      puts 'Running:'
      @queue.each do |command|
        puts "  #{command.command}"
      end
    end

    def run
      success = true
      list_queue unless @suppress_output
      @queue.each do |command|
        if command.run.failed?
          success = false
          command.display_error_message
          command.cleanup
          break
        end
      end
      puts "Done!" unless @suppress_output
      success
    end
  end
end
