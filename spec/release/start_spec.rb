require 'spec_helper'
require 'ind_flow/sandbox'
require 'ind_flow/sandbox/generate'

RSpec.describe 'ind_flow release start' do
  let(:version) { '0.0.1' }
  let(:release_branch) { "release/#{version}" }

  before do
    generator = IndFlow::Sandbox::Generate.new
    generator.run
    Dir.chdir generator.local_repository_directory
  end

  it 'starts a new release branch and pushes it to origin' do
    resp = ind_flow "release start -v #{version}"
    expect(resp.output).not_to include('There was a problem running')
    expect(`git branch`).to include(release_branch)
    expect(`git log`).to include('Initial commit')
    expect(`git status`).not_to include('Your branch is ahead of')
  end

  context 'when the branch already exists' do
    before do
      [
        "git checkout -b #{release_branch}",
        "touch foo",
        "git add .",
        "git commit -m \"Add foo\"",
        "git push origin #{release_branch}"
      ].each do |command|
        IndFlow::Command.new(command).run
      end
    end

    it 'should not create a new release branch' do
      resp = ind_flow "release start -v #{version}"
      expect(resp.output).to include('There was a problem running')
    end
  end

  context 'when version is not specified' do
    it 'should not create a new release branch' do
      resp = ind_flow 'release start'
      expect(`git branch`).not_to include(release_branch)
    end
  end
end
