module IndFlow
  class Sandbox < Thor
    desc 'generate', 'Generate a sandbox environment'
    option :override_origin, aliases: '-o'
    def generate
      override_origin = options[:override_origin]

      require 'ind_flow/sandbox/generate'
      Sandbox::Generate.new(override_origin: override_origin).run
    end
  end
end
