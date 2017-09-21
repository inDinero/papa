require 'spec_helper'

RSpec.shared_examples 'finish' do
  let(:build_branch) { "#{build_type}/#{version}" }
  let(:command) { papa "#{build_type} finish -v #{version}" }

  before do
    generator = Papa::Sandbox::Generate.new
    generator.run silent: true
    Dir.chdir generator.local_repository_directory
    papa "#{build_type} start -v #{version}"
    papa "#{build_type} add -v #{version} -b #{branches.join(' ')}"
  end

  it 'merges the build branch to master and develop and pushes it to origin' do
    expect(command[:exit_status]).to eq(0)

    ['develop', 'master'].each do |base_branch|
      `git checkout #{base_branch} > /dev/null 2>&1`
      merge_commits.each do |merge_commit|
        expect(`git log`).to include(merge_commit)
      end
      if base_branch == 'master'
        expect(`git log`).to include("Merge branch '#{build_branch}'")
      else
        expect(`git log`).to include("Merge branch '#{build_branch}' into #{base_branch}")
      end
      expect(`git log origin/#{base_branch}..#{base_branch}`).to be_empty
    end
  end

  context 'when version is not specified' do
    let(:command) { papa "#{build_type} finish" }

    it 'should not continue' do
      expect(command[:stderr]).to include('No value provided for required options')
      expect(command[:exit_status]).to eq(1)

      ['develop', 'master'].each do |base_branch|
        `git checkout #{base_branch} > /dev/null 2>&1`
        merge_commits.each do |merge_commit|
          expect(`git log`).not_to include(merge_commit)
        end
        if base_branch == 'master'
          expect(`git log`).not_to include("Merge branch '#{build_branch}'")
        else
          expect(`git log`).not_to include("Merge branch '#{build_branch}' into #{base_branch}")
        end
      end
    end
  end
end
