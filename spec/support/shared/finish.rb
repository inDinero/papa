require 'spec_helper'

RSpec.shared_examples 'finish' do
  let(:build_branch) { "#{build_type}/#{version}" }
  let(:command) { ind_flow "#{build_type} finish -v #{version}" }

  before do
    generator = IndFlow::Sandbox::Generate.new
    generator.run
    Dir.chdir generator.local_repository_directory
    ind_flow "#{build_type} start -v #{version}"
    ind_flow "#{build_type} add -v #{version} -b #{branches.join(' ')}"
  end

  it 'merges the build branch to master and develop' do
    expect(command.output).not_to include('There was a problem running')
    ['develop', 'master'].each do |base_branch|
      `git checkout #{base_branch} > /dev/null 2>&1`
      merge_commits.each do |merge_commit|
        expect(`git log`).to include(merge_commit)
      end
      expect(`git log`).to include("Merge branch '#{build_branch}' into #{base_branch}")
    end
  end
end
