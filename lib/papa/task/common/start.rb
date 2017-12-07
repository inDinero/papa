require 'papa/command/git/fetch'
require 'papa/command/git/checkout'
require 'papa/command/git/branch'
require 'papa/command/git/push'
require 'papa/runner'
require 'papa/helper/output'

module Papa
  module Task
    module Common
      class Start
        def run
          @build_branch ||= "#{@build_type}/#{@version}"

          runner = Runner.new(queue)

          if runner.run
            success_message
          else
            failure_message
            exit 1
          end
        end

        private

        def queue
          [
            Command::Git::Fetch.new('origin'),
            Command::Git::Checkout.new(@base_branch),
            Command::Git::Branch.new(@build_branch),
            Command::Git::Checkout.new(@build_branch),
            Command::Git::Push.new('origin', @build_branch)
          ]
        end

        def success_message
          Helper::Output.success "Successfully started new #{@build_type} branch #{@build_branch}"
        end

        def failure_message
          Helper::Output.failure "There was a problem starting #{@build_type} branch: #{@build_branch}"
        end
      end
    end
  end
end
