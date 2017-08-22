module IndFlow
  class CommandQueue
    attr_accessor :queue

    def initialize
      @queue = []
    end

    def add(command)
      @queue.push command
    end

    def list_queue
      puts 'In queue:'
      @queue.each do |command|
        puts command.command
      end
    end
  end
end
