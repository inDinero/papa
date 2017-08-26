require 'spec_helper'

RSpec.describe 'ind_flow hotfix start' do
  let(:build_type) { 'hotfix' }
  let(:version) { '0.0.1' }

  it_behaves_like 'start'
end
