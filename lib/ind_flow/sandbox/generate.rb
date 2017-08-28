module IndFlow
  class Sandbox::Generate
    attr_accessor :remote_repository_directory, :local_repository_directory, :git_details

    def initialize
      @remote_repository_directory = '/tmp/ind_flow_sandbox_remote_repository'
      @local_repository_directory = '/tmp/ind_flow_sandbox_local_repository'
      @git_details = [
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
        },
        {
          commit: 'APP-6 - Add pidgeotto gem',
          branch: 'feature/6-add-pidgeotto-gem',
          base_branch: 'develop'
        },
        {
          commit: 'APP-7 - Add pidgeot gem',
          branch: 'feature/7-add-pidgeot-gem',
          base_branch: 'develop'
        }
      ]
    end

    def run
      @project_directory = File.expand_path(File.dirname(__dir__))
      @branches_directory = File.join @project_directory, 'sandbox', 'branches'
      setup_remote_repository
      setup_local_repository
      success_message
      exit 0
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
      Command.new("rm -rf #{@remote_repository_directory}").run
      Dir.mkdir @remote_repository_directory
    end

    def initialize_remote_repository
      Dir.chdir @remote_repository_directory
      Command.new('git init --bare').run
    end

    def clone_remote_repository
      Command.new("rm -rf #{@local_repository_directory}").run
      Dir.mkdir @local_repository_directory
      Command.new("git clone #{@remote_repository_directory} #{@local_repository_directory}").run
      Dir.chdir @local_repository_directory
    end

    def initialize_master_and_develop
      [
        "cp #{gemfile_path('master')} #{@local_repository_directory}",
        'git add .',
        'git commit -m "Initial commit"',
        'git push origin master',
        'git checkout -b develop',
        'git push origin develop'
      ].each do |command|
        `#{command} #{Output::REDIRECT_TO_NULL}`
      end
    end

    def initialize_branches
      @git_details.each do |detail|
        commit = detail[:commit]
        branch = detail[:branch]
        base_branch = detail[:base_branch]
        [
          "git checkout #{base_branch}",
          "git checkout -b #{branch}",
          "rm #{temp_gemfile_path}",
          "cp #{gemfile_path(branch)} #{@local_repository_directory}",
          "git add .",
          "git commit -m \"#{commit}\"",
          "git push origin #{branch} --force"
        ].each do |command|
          `#{command} #{Output::REDIRECT_TO_NULL}`
        end
      end
    end

    def cleanup
      `git checkout develop #{Output::REDIRECT_TO_NULL}`
      @git_details.each do |detail|
        `git branch -D #{detail[:branch]} #{Output::REDIRECT_TO_NULL}`
      end
    end

    def success_message
      Output.stdout <<-STDOUT
Your sandbox is now available at:
  #{@local_repository_directory}
      STDOUT
    end
  end
end
