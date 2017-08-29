require 'spec_helper'

RSpec.describe 'papa hotfix start' do
  let(:build_type) { 'hotfix' }
  let(:version) { '0.0.1' }

  it_behaves_like 'start'
end
