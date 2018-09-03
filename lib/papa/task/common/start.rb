require 'papa/task/base'
require 'papa/command/git/branch'
require 'papa/command/git/push'
require 'papa/command/git/reset_hard'

module Papa
  module Task
    module Common
      class Start < Base
        private

        def queue
          [
            Command::Git::Fetch.new('origin'),
            Command::Git::Checkout.new(@base_branch),
            Command::Git::ResetHard.new('origin', @base_branch),
            Command::Git::Branch.new(build_branch),
            Command::Git::Checkout.new(build_branch),
            Command::Git::Push.new('origin', build_branch)
          ]
        end

        def success_message
          Helper::Output.success "Successfully started new #{@build_type} branch #{build_branch}"
        end

        def failure_message
          Helper::Output.failure "There was a problem starting #{@build_type} branch: #{build_branch}"
        end
      end
    end
  end
end
