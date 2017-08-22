module IndFlow
  class CLI < Thor
    desc "foo", "foo"
    def foo
      puts Git.fetch(remote: 'origin')[:exit_status]
    end
  end
end
