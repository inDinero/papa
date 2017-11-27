require 'papa/command/base'
require 'papa/command/git/rebase_abort'
require 'papa/command/git/checkout'

module Papa
  module Command
    module Git
      class Rebase < Command::Base
        def initialize(base_branch_name)
          @base_branch_name = base_branch_name
          command = "git rebase #{@base_branch_name}"
          super(command)
        end

        def run
          current_branch # Store current branch before executing command
          super
        end

        def cleanup
          super
          queue = [
            Git::RebaseAbort.new,
            Git::Checkout.new(current_branch)
          ]
          runner = Runner.new(queue)
          runner.run
        end

        def failure_message
          super
          message = "Failed to rebase #{current_branch} from #{@base_branch_name}. Merge conflict?"
          Helper::Output.error message
          message
        end
      end
    end
  end
end
