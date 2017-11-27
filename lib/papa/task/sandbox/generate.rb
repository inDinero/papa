require 'papa/helper/path'

module Papa
  module Task
    module Sandbox
      class Generate
        attr_accessor :remote_path, :local_path, :git_details, :options

        def initialize(options = {})
          @options = options
          @remote_path = Helper::Path.generate_sandbox_path('remote', options)
          @local_path = Helper::Path.generate_sandbox_path('local', options)
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
              branch: 'patch/17.8.0/3-add-pidgey-gem',
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
          Helper::Output.stdout('Started generation of sandbox...') unless options[:silent]
          @project_directory = File.expand_path(File.dirname(__dir__))
          @branches_directory = File.join @project_directory, 'task', 'sandbox', 'branches'
          setup_remote_repository
          setup_local_repository
          success_message unless options[:silent]
        end

        private

        def gemfile_path(branch)
          File.join @branches_directory, branch, 'Gemfile'
        end

        def temp_gemfile_path
          File.join @local_path, 'Gemfile'
        end

        def setup_remote_repository
          if options[:override_origin]
            create_local_path
            initialize_local_repository
            remove_old_branches_from_origin
          else
            create_remote_path
            initialize_remote_repository
            create_local_path
            clone_remote_repository
          end
        end

        def create_local_path
          Command.new("rm -rf #{@local_path}", options).run
          Dir.mkdir @local_path
        end

        def initialize_local_repository
          Dir.chdir @local_path
          Command.new('git init', options).run
          Command.new("git remote add origin #{options[:override_origin]}", options).run
        end

        def create_remote_path
          Command.new("rm -rf #{@remote_path}", options).run
          Dir.mkdir @remote_path
        end

        def initialize_remote_repository
          Dir.chdir @remote_path
          Command.new('git init --bare', options).run
        end

        def clone_remote_repository
          Command.new("git clone #{@remote_path} #{@local_path}", options).run
          Dir.chdir @local_path
        end

        def setup_local_repository
          initialize_master_and_develop
          initialize_branches
          cleanup
        end

        def remove_old_branches_from_origin
          `git fetch #{Helper::Output::REDIRECT_TO_NULL}`
          ['hotfix', 'release'].each do |branch|
            `git branch -r | grep #{branch}`.split("\n").each do |branch|
              branch = branch.strip.split('origin/').last
              `git push -d origin #{branch}`
            end
          end
        end

        def initialize_master_and_develop
          [
            "cp #{gemfile_path('master')} #{@local_path}",
            'git add .',
            'git commit -m "Initial commit"',
            'git push origin master --force',
            'git checkout -b develop',
            'git push origin develop --force'
          ].each do |command|
            `#{command} #{Helper::Output::REDIRECT_TO_NULL}`
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
              "cp #{gemfile_path(branch)} #{@local_path}",
              "git add .",
              "git commit -m \"#{commit}\"",
              "git push origin #{branch} --force"
            ].each do |command|
              `#{command} #{Helper::Output::REDIRECT_TO_NULL}`
            end
          end
        end

        def cleanup
          `git checkout develop #{Helper::Output::REDIRECT_TO_NULL}`
          @git_details.each do |detail|
            `git branch -D #{detail[:branch]} #{Helper::Output::REDIRECT_TO_NULL}`
          end
        end

        def success_message
          Helper::Output.success "Your sandbox is now available at:\n  #{@local_path}"
        end

        def override_origin(origin)
          [
            'git remote remove origin',
            'git remote add origin #{origin}'
          ].each do |command|
            `#{command} #{Helper::Output::REDIRECT_TO_NULL}`
          end
        end
      end
    end
  end
end
