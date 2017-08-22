module IndFlow
  class Git
    def self.status
      Command.new 'git status'
    end

    def self.fetch(remote:)
      Command.new "git fetch #{remote}"
    end

    def self.checkout(branch_name:)
      Command.new "git checkout #{branch_name}"
    end

    def self.branch(branch_name:)
      Command.new "git branch #{branch_name}"
    end

    def self.merge(branch_name:)
      Command.new "git merge #{branch_name} --no-ff"
    end

    def self.pull(remote:, branch_name:)
      Command.new "git pull #{remote} #{branch_name}"
    end

    def self.push(remote:, branch_name:)
      Command.new "git push #{remote} #{branch_name}"
    end

    def self.rebase(base_branch_name:)
      Command.new "git rebase #{base_branch_name}"
    end

    def self.tag(tag_name:)
      Command.new "git tag #{tag_name}"
    end

    def self.push_tag(remote:, tag_name:)
      push(remote: remote, branch_name: tag_name)
    end
  end
end
