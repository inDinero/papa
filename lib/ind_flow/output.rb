module IndFlow
  class Output
    REDIRECT_TO_NULL = '> /dev/null 2>&1'

    def self.stdout(message, options = {})
      puts message
    end

    def self.stderr(message, options = {})
      STDERR.puts message
    end
  end
end
