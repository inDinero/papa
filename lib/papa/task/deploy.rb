module Papa
  module Task
    class Deploy
      def initialize(options = {})
        @options = options
        build_options
      end

      def run
        queue = Runner.new
        queue.add Larga.type
        queue.add Larga.deploy(@options)
        if queue.run
          success_message
        else
          failure_message
          exit 1
        end
      end

      private

      def success_message
        Output.stdout 'Successfully deployed larga instance.'
      end

      def failure_message
        # TODO
      end

      def build_options
        return if !branch_is_release_or_hotfix?
        @options[:lifespan] = Larga::RELEASE_OR_HOTFIX_LIFESPAN
        @options[:protection] = Larga::RELEASE_OR_HOTFIX_PROTECTION
      end

      def branch_is_release_or_hotfix?
        branch_is_release? || branch_is_hotfix?
      end

      def branch_is_release?
        @options[:branch].include? 'release'
      end

      def branch_is_hotfix?
        @options[:branch].include? 'hotfix'
      end
    end
  end
end
