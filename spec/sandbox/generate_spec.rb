require 'spec_helper'

RSpec.describe  'papa sandbox generate' do
  let(:command) { papa "sandbox generate #{command_options}" }
  let(:command_options) { "--override-path-prefix #{path_prefix}" }

  shared_examples 'sandbox' do
    let(:path_prefix) { 'papa-sandbox' }
    let(:remote_path) { File.join('/tmp', path_prefix + '-remote') }
    let(:local_path) { File.join('/tmp', path_prefix + '-local') }
    let(:local_branches) {  ['develop', 'master'] }
    let(:remote_branches) {
      [
        'feature/1-add-butterfree-gem',
        'feature/2-add-beedrill-gem',
        'patch/17.8.0/3-add-pidgey-gem',
        'bugfix/4-fix-charmeleon-spelling',
        'bugfix/5-fix-gem-source',
        'feature/6-add-pidgeotto-gem',
        'feature/7-add-pidgeot-gem'
      ]
    }

    it 'generates the sandbox env successfully' do
      expect(command[:stdout]).to include('Started generation of sandbox...')
      expect(command[:stderr]).to be_empty
      expect(command[:exit_status]).to eq(0)

      expect(Dir.exists?(remote_path)).to be_truthy
      expect(Dir.exists?(local_path)).to be_truthy

      Dir.chdir(local_path)

      local_branches.each do |branch|
        expect(`git branch`).to include(branch)
      end

      remote_branches.each do |branch|
        expect(`git branch`).not_to include(branch)
      end

      remote_branches.each do |branch|
        expect(`git branch --remote`).to include("origin/#{branch}")

        `git checkout #{branch} #{Papa::Helper::Output::REDIRECT_TO_NULL}`
        expect(`git rev-list --count HEAD`.chomp).to eq('2')
      end
    end
  end

  it_behaves_like 'sandbox'

  context 'when override origin is specified' do
    let(:command_options) { "--override-path-prefix #{path_prefix} --override-origin #{remote_path}" }

    it_behaves_like 'sandbox'
  end
end
