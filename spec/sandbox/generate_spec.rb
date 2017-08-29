require 'spec_helper'

RSpec.describe  'ind_flow sandbox generate' do
  let(:command) { ind_flow 'sandbox generate' }
  let(:remote_repo_directory) { '/tmp/ind_flow_sandbox_remote_repository' }
  let(:local_repo_directory) { '/tmp/ind_flow_sandbox_local_repository' }
  let(:local_branches) {  ['develop', 'master'] }
  let(:remote_branches) {
    [
      'feature/1-add-butterfree-gem',
      'feature/2-add-beedrill-gem',
      'patch/0.0.1/3-add-pidgey-gem',
      'bugfix/4-fix-charmeleon-spelling',
      'bugfix/5-fix-gem-source',
      'feature/6-add-pidgeotto-gem',
      'feature/7-add-pidgeot-gem'
    ]
  }

  shared_examples 'sandbox' do
    it 'generates the sandbox env successfully' do
      expect(command[:stderr]).to be_empty
      expect(command[:exit_status]).to eq(0)

      expect(Dir.exists?(remote_repo_directory)).to be_truthy
      expect(Dir.exists?(local_repo_directory)).to be_truthy

      Dir.chdir(local_repo_directory)

      local_branches.each do |branch|
        expect(`git branch`).to include(branch)
      end

      remote_branches.each do |branch|
        expect(`git branch`).not_to include(branch)
      end

      remote_branches.each do |branch|
        expect(`git branch --remote`).to include("origin/#{branch}")

        `git checkout #{branch} #{IndFlow::Output::REDIRECT_TO_NULL}`
        expect(`git rev-list --count HEAD`.chomp).to eq('2')
      end
    end
  end

  it_behaves_like 'sandbox'

  context 'when override origin is specified' do
    let(:command) { ind_flow "sandbox generate --override-origin #{remote_repo_directory}" }

    before do
      `rm -rf #{remote_repo_directory} #{IndFlow::Output::REDIRECT_TO_NULL}`
      Dir.mkdir remote_repo_directory
      Dir.chdir remote_repo_directory
      `git init --bare #{IndFlow::Output::REDIRECT_TO_NULL}`
    end

    it_behaves_like 'sandbox'
  end
end
