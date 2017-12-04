module Papa
  module CLI
    class Integration < Thor
      desc 'start', 'Start an integration branch and deploy it to Larga'
      option :base_branch, aliases: '-b', required: true
      option :hostname, aliases: '-h'
      option :skip_larga
      def start
        base_branch = options[:base_branch]
        hostname = options[:hostname]
        skip_larga = options.has_key?('skip_larga')

        require 'papa/task/integration/start'
        Task::Integration::Start.new(base_branch: base_branch, hostname: hostname, skip_larga: skip_larga).run
      end
    end
  end
end
