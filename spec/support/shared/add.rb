require 'spec_helper'

RSpec.shared_examples 'add' do
  let(:build_branch) { "#{build_type}/#{version}" }
  let(:merge_commits) do
    branches.map do |branch|
      "Merge branch '#{branch}' into #{build_branch}"
    end
  end
  let(:command) { ind_flow "#{build_type} add -v #{version} -b #{branches.join(' ')}" }

  before do
    generator = IndFlow::Sandbox::Generate.new
    generator.run
    Dir.chdir generator.local_repository_directory
    ind_flow "#{build_type} start -v #{version}"
  end

  it 'adds a branch to the build branch and pushes it to origin' do
    expect(command.output).not_to include('There was a problem running')
    expect(`git branch`).to include(build_branch)
    merge_commits.each do |merge_commit|
      expect(`git log`).to include(merge_commit)
    end
    expect(`git status`).not_to include('Your branch is ahead of')
  end

  it 'cleans up and removes stale branches from local' do
    command
    branches.each do |branch|
      expect(`git branch`).not_to include(branch)
    end
  end

  context 'when branch does not exist' do
    let(:branches) { [ "#{build_type}/404-not-found" ] }

    it 'should not add to the build branch' do
      expect(command.output).to include('There was a problem running')
    end
  end

  shared_examples 'should not continue' do
    it 'should not continue' do
      command
      merge_commits.each do |merge_commit|
        expect(`git log`).not_to include(merge_commit)
      end
    end
  end

  context 'when version is not specified' do
    let(:command) { ind_flow "#{build_type} add -b #{branches.join(' ')}" }
    it_behaves_like 'should not continue'
  end

  context 'when branch(es) is(are) not specified' do
    let(:command) { ind_flow "#{build_type} add -v #{version}" }
    it_behaves_like 'should not continue'
  end
end

RSpec.shared_examples 'add with merge conflict' do
  let(:build_branch) { "#{build_type}/#{version}" }
  let(:merge_commits) do
    branches.map do |branch|
      "Merge branch '#{branch}' into #{build_branch}"
    end
  end
  let(:command) { ind_flow "#{build_type} add -v #{version} -b #{branches.join(' ')}" }

  before do
    generator = IndFlow::Sandbox::Generate.new
    generator.run
    Dir.chdir generator.local_repository_directory
    ind_flow "#{build_type} start -v #{version}"
  end

  it 'should merge the branches with no conflicts' do
    expect(command.output).to include(error_message)
    expected_success_branches.each do |branch|
      expect(`git log`).to include("Merge branch '#{branch}' into #{build_branch}")
    end
  end
end
