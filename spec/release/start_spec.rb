require 'spec_helper'

RSpec.describe 'ind_flow release start' do
  let(:build_type) { 'release' }
  let(:version) { '0.0.1' }

  it_behaves_like 'start'
end
