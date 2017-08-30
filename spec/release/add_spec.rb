require 'spec_helper'

RSpec.describe 'papa release add' do
  let(:build_type) { 'release' }
  let(:version) { '0.0.1' }
  let(:branches) do
    [
      'feature/1-add-butterfree-gem',
      'feature/2-add-beedrill-gem'
    ]
  end

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
