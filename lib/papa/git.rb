module Papa
  class Git
    def self.status
      Command.new 'git status'
    end

    def self.fetch(remote:)
      require 'papa/git/fetch'

      Git::Fetch.new(remote)
    end

    def self.checkout(branch_name:)
      require 'papa/git/checkout'

      Git::Checkout.new(branch_name)
    end

    def self.branch(branch_name:)
      Command.new "git branch #{branch_name}"
    end

    def self.delete_branch(branch_name:)
      Command.new "git branch -D #{branch_name}"
    end

    def self.merge(branch_name:)
      require 'papa/git/merge'

      Git::Merge.new(branch_name)
    end

    def self.merge_abort
      Command.new 'git merge --abort'
    end

    def self.pull(remote:, branch_name:)
      Command.new "git pull #{remote} #{branch_name}"
    end

    def self.push(remote:, branch_name:)
      Command.new "git push #{remote} #{branch_name}"
    end

    def self.force_push(remote:, branch_name:)
      Command.new "git push #{remote} #{branch_name} --force-with-lease"
    end

    def self.rebase(base_branch_name:)
      require 'papa/git/rebase'

      Git::Rebase.new(base_branch_name)
    end

    def self.rebase_abort
      Command.new 'git rebase --abort'
    end

    def self.tag(tag_name:)
      Command.new "git tag #{tag_name}"
    end

    def self.push_tag(remote:, tag_name:)
      push(remote: remote, branch_name: tag_name)
    end
  end
end
