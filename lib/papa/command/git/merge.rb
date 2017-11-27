require 'papa/command/base'

module Papa
  module Command
    module Git
      class Merge < Command::Base
        def initialize(branch_name)
          @branch_name = branch_name
          command = "git merge #{@branch_name} --no-ff"
          super(command)
        end

        def run
          current_branch # Store current branch before executing command
          super
        end

        def cleanup
          super
          queue = Runner.new
          queue.add Git.merge_abort
          queue.add Git.checkout(branch_name: current_branch)
          queue.run
        end

        def failure_message
          super
          message = "Failed to merge #{@branch_name} into #{current_branch}. Merge conflict?"
          Output.error message
          message
        end
      end
    end
  end
end
