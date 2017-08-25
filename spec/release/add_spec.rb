require 'spec_helper'

RSpec.describe 'ind_flow release add' do
  let(:version) { '0.0.1' }
  let(:release_branch) { "release/#{version}" }
  let(:feature_branches) do
    [
      'feature/1-add-butterfree-gem',
      'feature/2-add-beedrill-gem'
    ]
  end
  let(:merge_commits) do
    feature_branches.map do |branch|
      "Merge branch '#{branch}' into #{release_branch}"
    end
  end
  let(:command) { ind_flow "release add -v #{version} -b #{feature_branches.join(' ')}" }

  before do
    generator = IndFlow::Sandbox::Generate.new
    generator.run
    Dir.chdir generator.local_repository_directory
    ind_flow "release start -v #{version}"
  end

  it 'adds a feature branch to the release branch and pushes it to origin' do
    expect(command.output).not_to include('There was a problem running')
    expect(`git branch`).to include(release_branch)
    merge_commits.each do |merge_commit|
      expect(`git log`).to include(merge_commit)
    end
    expect(`git status`).not_to include('Your branch is ahead of')
  end

  it 'cleans up and removes feature branches from local' do
    command
    feature_branches.each do |feature_branch|
      expect(`git branch`).not_to include(feature_branch)
    end
  end

  context 'when there is a merge conflict' do
    let(:feature_branches) do
      [
        'feature/6-add-pidgeotto-gem',
        'feature/7-add-pidgeot-gem',
        'feature/1-add-butterfree-gem'
      ]
    end

    it 'should merge the branches with no conflicts' do
      expect(command.output).to include("These branches failed:\n  feature/7-add-pidgeot-gem")
      [
        'feature/6-add-pidgeotto-gem',
        'feature/1-add-butterfree-gem'
      ].each do |branch|
        expect(`git log`).to include("Merge branch '#{branch}' into #{release_branch}")
      end
    end
  end

  context 'when branch does not exist' do
    let(:feature_branches) { [ 'feature/404-not-found' ] }

    it 'should not add to the release branch' do
      expect(command.output).to include('There was a problem running')
    end
  end

  shared_examples 'should not continue' do
    it 'should not continue' do
      command.call
      merge_commits.each do |merge_commit|
        expect(`git log`).not_to include(merge_commit)
      end
    end
  end

  context 'when version is not specified' do
    let(:command) { lambda { ind_flow "release add -b #{feature_branches.join(' ')}" } }
    it_behaves_like 'should not continue'
  end

  context 'when branch(es) is(are) not specified' do
    let(:command) { lambda { ind_flow "release add -v #{version}" } }
    it_behaves_like 'should not continue'
  end
end
