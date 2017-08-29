require 'spec_helper'

RSpec.describe 'papa release finish' do
  let(:build_type) { 'release' }
  let(:version) { '0.0.1' }
  let(:branches) do 
    [
      'feature/1-add-butterfree-gem',
      'feature/2-add-beedrill-gem'
    ]
  end
  let(:merge_commits) do
    branches.map do |branch|
      "Merge branch '#{branch}' into #{build_branch}"
    end
  end

  it_behaves_like 'finish'
end
