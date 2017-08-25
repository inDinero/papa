require 'spec_helper'

RSpec.shared_examples 'start' do
  let(:build_branch) { "#{build_type}/#{version}" }
  let(:command) { ind_flow "#{build_type} start -v #{version}" }

  before do
    generator = IndFlow::Sandbox::Generate.new
    generator.run
    Dir.chdir generator.local_repository_directory
  end

  it "starts a new build branch and pushes it to origin" do
    expect(command.output).not_to include('There was a problem running')
    expect(`git branch`).to include(build_branch)
    expect(`git log`).to include('Initial commit')
    expect(`git status`).not_to include('Your branch is ahead of')
  end

  context 'when the branch already exists' do
    before do
      [
        "git checkout -b #{build_branch}",
        "touch foo",
        "git add .",
        "git commit -m \"Add foo\"",
        "git push origin #{build_branch}"
      ].each do |command|
        IndFlow::Command.new(command).run
      end
    end

    it "should not create a new build branch" do
      expect(command.output).to include('There was a problem running')
    end
  end

  context 'when version is not specified' do
    let(:command) { ind_flow "#{build_type} start" }

    it 'should not continue' do
      command
      expect(`git branch`).not_to include(build_branch)
    end
  end
end
