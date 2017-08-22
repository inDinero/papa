module IndFlow
  class Git
    def self.status
      Commander.send_command 'git status'
    end

    def self.fetch(remote:)
      Commander.send_command "git fetch #{remote}"
    end

    def self.checkout(branch_name:)
      Commander.send_command "git checkout #{branch_name}"
    end

    def self.branch(branch_name:)
      Commander.send_command "git branch #{branch_name}"
    end

    def self.merge(branch_name:)
      Commander.send_command "git branch #{branch_name}"
    end

    def self.push(remote:, branch_name:)
      Commander.send_command "git push #{remote} #{branch_name}"
    end

    def self.rebase(base_branch_name:)
      Commander.send_command "git rebase #{base_branch_name}"
    end

    def self.tag(tag_name:)
      Commander.send_command "git tag #{tag_name}"
    end

    def self.push_tag(remote:, tag_name:)
      push(remote: remote, branch_name: tag_name)
    end
  end
end
