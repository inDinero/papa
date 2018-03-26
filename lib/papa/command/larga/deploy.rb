require 'papa/command/base'

module Papa
  module Command
    module Larga
      class Deploy < Command::Base
        RELEASE_OR_INTEGRATION_LIFESPAN = '3d'
        RELEASE_OR_INTEGRATION_PROTECTION = 'off'

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
            Helper::Output.info line
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
          action = determine_action
          branch = @options[:branch]
          lifespan = RELEASE_OR_INTEGRATION_LIFESPAN
          protection = RELEASE_OR_INTEGRATION_PROTECTION
          hostname = @options[:hostname]

          options = []
          options << "-action #{action}"
          options << "-branch #{branch}"
          options << "-lifespan #{lifespan}"
          options << "-protection #{protection}"
          options << "-hostname #{hostname}"
          options
        end

        def determine_action
          previous_branches = `larga -action show -branch x | grep https://#{@options[:hostname]} | awk '{print $1}'`.chomp.split("\n")
          if previous_branches.empty?
            # If there are no old instances with the same hostname, continue building instance.
            return 'build'
          elsif previous_branches.count == 1 && previous_branches.include?(@options[:branch])
            # If the old instance has the same branch name, skip building and just deploy.
            return 'deploy'
          else
            # If all else fails, destroy old instance(s), and continue building.
            destroy_old_instances(previous_branches)
            return 'build'
          end
        end

        def destroy_old_instances(previous_branches)
          Helper::Output.stdout "Destroying old instances..."
          previous_branches.each do |previous_branch|
            destroy_command = "larga -action destroy -branch #{previous_branch}"
            Helper::Output.stdout "Running #{destroy_command.bold}..."
            IO.popen(destroy_command).each do |line|
              Helper::Output.info line
            end
          end
        end
      end
    end
  end
end
