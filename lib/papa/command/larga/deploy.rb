require 'papa/command/base'

module Papa
  module Command
    module Larga
      class Deploy < Command::Base
        def initialize(branch, lifespan, protection, hostname)
          @branch = branch
          @lifespan = lifespan
          @protection = protection
          @hostname = hostname

          command = "larga #{build_options.join(' ')}"
          super(command, silent: false)
        end

        def failed?
          @output.include? 'Cowardly refusing'
        end

        def failure_message
          super
          Output.stderr 'ERROR: Ensure that the branch exists before trying again'
        end

        private

        def build_options()
          options = []
          options << '-action deploy'
          options << "-branch #{@branch}"
          options << "-lifespan #{@lifespan}"
          options << "-protection #{@protection}"
          if @hostname
            options << "-hostname #{@hostname}"
          end
          options
        end
      end
    end
  end
end
