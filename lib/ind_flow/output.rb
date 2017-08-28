module IndFlow
  class Output
    def self.stdout(message, options = {})
      puts message
    end

    def self.stderr(message, options = {})
      STDERR.puts message
    end
  end
end
