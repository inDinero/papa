require 'spec_helper'

RSpec.describe 'ind_flow hotfix add' do
  let(:build_type) { 'hotfix' }
  let(:version) { '0.0.1' }
  let(:branches) do
    [
      'bugfix/4-fix-charmeleon-spelling',
      'bugfix/5-fix-gem-source'
    ]
  end

  it_behaves_like 'add'

  context 'when there is a merge conflict' do
    #TODO: Use bugfix branches instead of feature branches, but this should work the same as is.
    let(:branches) do
      [
        'feature/6-add-pidgeotto-gem',
        'feature/7-add-pidgeot-gem',
        'feature/1-add-butterfree-gem'
      ]
    end
    let(:error_message) { "These branches failed:\n  feature/7-add-pidgeot-gem" }
    let(:expected_success_branches) { 
      [
        'feature/6-add-pidgeotto-gem',
        'feature/1-add-butterfree-gem'
      ]
    }

    it_behaves_like 'add with merge conflict'
  end
end
