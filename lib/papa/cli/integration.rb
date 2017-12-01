module Papa
  module CLI
    class Integration < Thor
      desc 'start', 'Start an integration branch and deploy it to Larga'
      option :base_branch, aliases: '-b', required: true
      option :hostname, aliases: '-h'
      def start
        base_branch = options[:base_branch]
        hostname = options[:hostname]

        require 'papa/task/integration/start'
        Task::Integration::Start.new(base_branch: base_branch, hostname: hostname).run
      end
    end
  end
end
