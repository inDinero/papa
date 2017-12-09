require 'papa/command/base'

module Papa
  module Command
    module Larga
      class Deploy < Command::Base
        RELEASE_OR_HOTFIX_LIFESPAN = '3d'
        DEFAULT_LIFESPAN = '4h'
        RELEASE_OR_HOTFIX_PROTECTION = 'off'
        DEFAULT_PROTECTION = 'on'

        def initialize(options)
          @options = options

          command = "larga #{larga_options.join(' ')}"
          super(command, silent: false)
        end

        def run
          Helper::Output.stdout "Running #{command.bold}..."
          @stdout = ''
          IO.popen(command).each do |line|
            @stdout << line
            puts line
          end
          self
        end

        def failure_message
          message = "Error while running #{command.bold}"
          Helper::Output.error message
        end

        def failed?
          stdout.include?('Cowardly refusing') || stdout.include?('Error')
        end

        private

        def larga_options
          branch = @options[:branch]
          lifespan =
            if branch_is_release_or_hotfix?
              RELEASE_OR_HOTFIX_LIFESPAN
            else
              DEFAULT_LIFESPAN
            end
          protection =
            if branch_is_release_or_hotfix?
              RELEASE_OR_HOTFIX_PROTECTION
            else
              DEFAULT_PROTECTION
            end
          hostname = @options[:hostname]

          options = []
          options << '-action build'
          options << "-branch #{branch}"
          options << "-lifespan #{lifespan}"
          options << "-protection #{protection}"
          options << "-hostname #{hostname}" if hostname
          options
        end

        def branch_is_release_or_hotfix?
          ['release', 'hotfix'].any? { |s| @options[:branch].include?(s) }
        end
      end
    end
  end
end
