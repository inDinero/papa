require 'papa/command/base'

module Papa
  module Command
    module Git
      class Checkout < Command::Base
        def initialize(branch_name)
          @branch_name = branch_name
          command = "git checkout #{@branch_name}"
          super(command)
        end

        def failure_message
          super
          message = "Failed to checkout #{@branch_name.bold}. Check whether this branch exists."
          Helper::Output.error message
          message
        end
      end
    end
  end
end
