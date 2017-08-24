module IndFlow
  class Sandbox::Generate
    def initialize
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
      @repo_directory = File.expand_path(File.dirname(__dir__))
      @branches_directory = File.join @repo_directory, 'sandbox', 'branches'
      create_temp_directory
      initialize_git_repository
      add_remote
      initialize_master_and_develop
      initialize_branches
    end

    private

    def create_temp_directory
      @temp_directory = '/tmp/ind_flow_sandbox'
      `rm -rf #{@temp_directory}`
      Dir.mkdir @temp_directory
    end

    def gemfile_path(branch)
      File.join @branches_directory, branch, 'Gemfile'
    end

    def temp_gemfile_path
      File.join @temp_directory, 'Gemfile'
    end

    def initialize_git_repository
      Dir.chdir @temp_directory
      `git init`
    end

    def add_remote
      puts "Enter the remote URL for your GitHub repository:"
      # origin = STDIN.gets.chomp
      origin = "git@github.com:b-ggs/ind_flow.git"
      `git remote add origin #{origin}`
    end

    def initialize_master_and_develop
      `cp #{gemfile_path('master')} #{@temp_directory}`
      `git init`
      `git add .`
      `git commit -m "Initial commit"`
      `git push origin master --force`
      `git checkout -b develop`
      `git push origin develop --force`
    end

    def initialize_branches
      @details.each do |detail|
        commit = detail[:commit]
        branch = detail[:branch]
        base_branch = detail[:base_branch]

        `git checkout #{base_branch}`
        `git checkout -b #{branch}`
        `rm #{temp_gemfile_path}`
        `cp #{gemfile_path(branch)} #{@temp_directory}`
        `git add .`
        `git commit -m "#{commit}"`
        `git push origin #{branch} --force`
      end
    end
  end
end
