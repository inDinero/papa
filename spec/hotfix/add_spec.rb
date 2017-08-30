require 'spec_helper'

RSpec.describe 'papa hotfix add' do
  let(:build_type) { 'hotfix' }
  let(:version) { '0.0.1' }
  let(:branches) do
    [
      'bugfix/4-fix-charmeleon-spelling',
      'bugfix/5-fix-gem-source'
    ]
  end

  it_behaves_like 'add'

j context 'when there is a merge conflict' do
    #TODO: Use bugfix branches instead of feature branches, but this should work the same as is.
    let(:branches) do
      [
        'feature/6-add-pidgeotto-gem',
        'feature/7-add-pidgeot-gem',
        'feature/1-add-butterfree-gem'
      ]
    end
    let(:expected_success_branches) { 
      [
        'feature/6-add-pidgeotto-gem',
        'feature/1-add-butterfree-gem'
      ]
    }
    let(:expected_failed_branches) { 'feature/7-add-pidgeot-gem' }

    it_behaves_like 'add with merge conflict'
  end
end
