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


    def run(options = {})
      errors = []

      if options[:skip_confirmation] || confirm
        @queue.each do |command|
          if command.run.failed?
            command.display_error_message
            command.cleanup
            break
          end
        end
      else
        puts "Stopped."
      end
      errors
    end

    private

    def confirm
      list_queue
      puts "Are you sure you want to run the following commands? (y, N)"
      STDIN.gets.chomp.downcase == 'y'
    end
  end
end
