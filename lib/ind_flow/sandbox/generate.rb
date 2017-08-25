module IndFlow
  class Sandbox::Generate
    def initialize(options = {})
      @remote_repository_directory = '/tmp/ind_flow_sandbox_remote_repository'
      @local_repository_directory = '/tmp/ind_flow_sandbox_local_repository'
      @details = [
        {
          commit: 'APP-1 - Add butterfree gem',
          branch: 'feature/1-add-butterfree-gem',
          base_branch: 'develop'
        },
        {
          commit: 'APP-2 - Add beedrill gem',
          branch: 'feature/2-add-beedrill-gem',
          base_branch: 'develop'
        },
        {
          commit: 'APP-3 - Add pidgey gem',
          branch: 'patch/0.0.1/3-add-pidgey-gem',
          base_branch: 'develop'
        },
        {
          commit: 'APP-4 - Fix charmeleon spelling',
          branch: 'bugfix/4-fix-charmeleon-spelling',
          base_branch: 'master'
        },
        {
          commit: 'APP-5 - Fix gem source',
          branch: 'bugfix/5-fix-gem-source',
          base_branch: 'master'
        }
      ]
    end

    def run
      @project_directory = File.expand_path(File.dirname(__dir__))
      @branches_directory = File.join @project_directory, 'sandbox', 'branches'
      setup_remote_repository
      setup_local_repository
    end

    private

    def gemfile_path(branch)
      File.join @branches_directory, branch, 'Gemfile'
    end

    def temp_gemfile_path
      File.join @local_repository_directory, 'Gemfile'
    end

    def setup_remote_repository
      create_remote_repository_directory
      initialize_remote_repository
    end

    def setup_local_repository
      clone_remote_repository
      initialize_master_and_develop
      initialize_branches
      cleanup
    end

    def create_remote_repository_directory
      `rm -rf #{@remote_repository_directory}`
      Dir.mkdir @remote_repository_directory
    end

    def initialize_remote_repository
      Dir.chdir @remote_repository_directory
      `git init --bare`
    end

    def clone_remote_repository
      `rm -rf #{@local_repository_directory}`
      Dir.mkdir @local_repository_directory
      `git clone #{@remote_repository_directory} #{@local_repository_directory}`
      Dir.chdir @local_repository_directory
    end

    def initialize_master_and_develop
      `cp #{gemfile_path('master')} #{@local_repository_directory}`
      `git add .`
      `git commit -m "Initial commit"`
      `git push origin master`
      `git checkout -b develop`
      `git push origin develop`
    end

    def initialize_branches
      @details.each do |detail|
        commit = detail[:commit]
        branch = detail[:branch]
        base_branch = detail[:base_branch]

        `git checkout #{base_branch}`
        `git checkout -b #{branch}`
        `rm #{temp_gemfile_path}`
        `cp #{gemfile_path(branch)} #{@local_repository_directory}`
        `git add .`
        `git commit -m "#{commit}"`
        `git push origin #{branch} --force`
      end
    end

    def cleanup
      `git checkout develop`
      @details.each do |detail|
        `git branch -D #{detail[:branch]}`
      end
    end
  end
end
