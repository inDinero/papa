module IndFlow
  class Sandbox < Thor
    desc 'generate', 'Generate a sandbox environment'
    def generate
      require 'ind_flow/sandbox/generate'

      Sandbox::Generate.new.run
    end
  end
end
