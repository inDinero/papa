require 'papa/command/git/fetch'
require 'papa/command/git/checkout'
require 'papa/runner'
require 'papa/helper/output'

module Papa
  module Task
    class Base
      def run
        perform_task
        result
      end

      private

      def perform_task
        runner = Runner.new(queue)
        @success = runner.run
      end

      def result
        if @success
          success_message
        else
          failure_message
          exit 1
        end
      end

      def build_branch
        @build_branch ||= "#{@build_type}/#{@version}"
      end

      def check_if_build_branch_exists
        queue = [
          Command::Git::Fetch.new('origin'),
          Command::Git::Checkout.new(build_branch)
        ]
        runner = Runner.new(queue)
        return if runner.run
        Helper::Output.failure 'Build branch does not exist.'
        exit 1
      end
    end
  end
end
