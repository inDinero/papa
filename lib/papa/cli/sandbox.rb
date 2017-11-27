module Papa
  module CLI
    class Sandbox < Thor
      desc 'generate', 'Generate a sandbox environment'
      option :override_origin, aliases: '-o'
      option :override_path_prefix, aliases: '-p'
      def generate
        require 'papa/task/sandbox/generate'
        Task::Sandbox::Generate.new(options).run
      end

      desc 'clean', 'Clean up sandbox directories in /tmp'
      def clean
        require 'papa/task/sandbox/clean'
        Task::Sandbox::Clean.new.run
      end
    end
  end
end
