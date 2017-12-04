require 'spec_helper'
require 'date'

RSpec.describe 'papa integration start' do
  let(:build_type) { 'integration' }
  let(:version) { DateTime.now.strftime('%y.%m.%d.%H.%M').gsub('.0', '.') }
  let(:option) { '--base-branch' }
  let(:option_value) { 'develop' }
  let(:extra_options) { '--skip-larga' }

  it_behaves_like 'start'
end
