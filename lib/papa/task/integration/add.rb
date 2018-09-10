require 'papa/task/common/add'

module Papa
  module Task
    module Integration
      class Add < Common::Add
        def initialize(version, branches)
          @build_type = 'integration'
          @version = version
          @branches = branches
          super()
        end

        def queue(branch)
          [
            Command::Git::Checkout.new(build_branch),
            Command::Git::ResetHard.new('origin', build_branch),
            Command::Git::Checkout.new(branch),
            Command::Git::ResetHard.new('origin', branch),
            Command::Git::Rebase.new(build_branch),
            Command::Git::Checkout.new(build_branch),
            Command::Git::Merge.new(branch),
            Command::Git::BranchDelete.new(branch),
            Command::Git::Push.new('origin', build_branch)
          ]
        end
      end
    end
  end
end
