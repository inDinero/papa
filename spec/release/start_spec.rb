require 'spec_helper'

RSpec.describe 'papa release start' do
  let(:build_type) { 'release' }
  let(:version) { '0.0.1' }
  let(:option) { '--version' }
  let(:option_value) { version }
  let(:extra_options) { '' }

  it_behaves_like 'start'
end
