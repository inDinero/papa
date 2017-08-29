require 'spec_helper'

RSpec.describe 'papa release start' do
  let(:build_type) { 'release' }
  let(:version) { '0.0.1' }

  it_behaves_like 'start'
end
