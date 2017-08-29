require 'spec_helper'

RSpec.describe 'papa hotfix finish' do
  let(:build_type) { 'hotfix' }
  let(:version) { '0.0.1' }
  let(:branches) do
    [
      'bugfix/4-fix-charmeleon-spelling',
      'bugfix/5-fix-gem-source'
    ]
  end
  let(:merge_commits) do
    branches.map do |branch|
      "Merge branch '#{branch}' into #{build_branch}"
    end
  end

  it_behaves_like 'finish'
end
