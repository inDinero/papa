require 'spec_helper'

RSpec.shared_examples 'start' do
  let(:build_branch) { "#{build_type}/#{version}" }
  let(:command) { papa "#{build_type} start #{option} #{option_value} #{extra_options}" }

  before do
    generator = Papa::Task::Sandbox::Generate.new(silent: true)
    generator.run
    Dir.chdir generator.local_path
  end

  it "starts a new build branch and pushes it to origin" do
    expect(command[:exit_status]).to eq(0)

    expect(`git branch`).to include(build_branch)
    expect(`git log`).to include('Initial commit')
    expect(`git log origin/#{build_branch}..#{build_branch}`).to be_empty
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
        `#{command} #{Papa::Helper::Output::REDIRECT_TO_NULL}`
      end
    end

    it "should not create a new build branch" do
      expect(command[:exit_status]).to eq(1)
    end
  end

  context 'when options are not specified' do
    let(:command) { papa "#{build_type} start" }

    it 'should not continue' do
      expect(command[:stderr]).to include("No value provided for required options '#{option}'")
      expect(command[:exit_status]).to eq(1)

      expect(`git branch`).not_to include(build_branch)
    end
  end
end
