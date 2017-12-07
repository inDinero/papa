require 'spec_helper'

RSpec.describe 'papa integration add' do
  let(:build_type) { 'integration' }
  let(:version) { 'dunder-mifflin' }
  let(:branches) do
    [
      'bugfix/4-fix-charmeleon-spelling',
      'bugfix/5-fix-gem-source'
    ]
  end
  let(:start_command) { papa "integration start -b develop --override-branch-name #{version}" }

  it_behaves_like 'add'

  context 'when there is a merge conflict' do
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
