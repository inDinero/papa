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
        puts "  #{command.command}"
      end
    end

    def run
      list_queue
      puts "Are you sure you want to run the following commands? (y, N)"
      resp = STDIN.gets.chomp
      if resp.downcase == 'y'
        @queue.each do |command|
          if command.run.failed?
            puts "Command failed"
            break
          end
        end
      else
        puts "Stopped."
      end
    end
  end
end
