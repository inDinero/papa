require 'spec_helper'

RSpec.shared_examples 'add' do
  let(:build_branch) { "#{build_type}/#{version}" }
  let(:merge_commits) do
    branches.map do |branch|
      "Merge branch '#{branch}' into #{build_branch}"
    end
  end
  let(:command) { papa "#{build_type} add -v #{version} -b #{branches.join(' ')}" }

  before do
    generator = Papa::Task::Sandbox::Generate.new(silent: true)
    generator.run
    Dir.chdir generator.local_path
    papa "#{build_type} start -v #{version}"
  end

  it 'adds a branch to the build branch and pushes it to origin' do
    expect(command[:exit_status]).to eq(0)

    expect(`git branch`).to include(build_branch)
    merge_commits.each do |merge_commit|
      expect(`git log`).to include(merge_commit)
    end
    expect(`git log origin/#{build_branch}..#{build_branch}`).to be_empty
  end

  it 'cleans up and removes stale branches from local' do
    expect(command[:exit_status]).to eq(0)

    branches.each do |branch|
      expect(`git branch`).not_to include(branch)
    end
  end

  context 'when build branch does not exist' do
    let(:command) { papa "#{build_type} add -v dunder-mifflin-this-is-pam -b #{branches.join(' ')}" }

    it 'should fail with an error' do
      expect(command[:exit_status]).to eq(1)
      expect(command[:stderr]).to include('Build branch does not exist.')
    end
  end

  context 'when branch does not exist' do
    let(:branches) { [ "#{build_type}/404-not-found" ] }

    it 'should not add to the build branch' do
      expect(command[:exit_status]).to eq(1)
    end
  end

  shared_examples 'should not continue' do
    it 'should not continue' do
      expect(command[:exit_status]).to eq(1)
      merge_commits.each do |merge_commit|
        expect(`git log`).not_to include(merge_commit)
      end
    end
  end

  context 'when version is not specified' do
    let(:command) { papa "#{build_type} add -b #{branches.join(' ')}" }

    it_behaves_like 'should not continue'

    it 'should return a helpful error' do
      expect(command[:stderr]).to include('No value provided for required options \'--version\'')
    end
  end
end

RSpec.shared_examples 'add with merge conflict' do
  let(:build_branch) { "#{build_type}/#{version}" }
  let(:merge_commits) do
    branches.map do |branch|
      "Merge branch '#{branch}' into #{build_branch}"
    end
  end
  let(:command) { papa "#{build_type} add -v #{version} -b #{branches.join(' ')}" }

  before do
    generator = Papa::Task::Sandbox::Generate.new(silent: true)
    generator.run
    Dir.chdir generator.local_path
    papa "#{build_type} start -v #{version}"
  end

  it 'should merge the branches with no conflicts' do
    expect(command[:stderr]).to include(expected_failed_branches)
    expect(command[:exit_status]).to eq(1)

    expected_success_branches.each do |branch|
      expect(`git log`).to include("Merge branch '#{branch}' into #{build_branch}")
    end
  end
end
