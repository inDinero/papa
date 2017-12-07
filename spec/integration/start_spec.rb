require 'spec_helper'
require 'date'

RSpec.describe 'papa integration start' do
  let(:build_type) { 'integration' }
  let(:version) { 'dunder-mifflin' }
  let(:option) { '--base-branch' }
  let(:option_value) { 'develop' }
  let(:extra_options) { "--override-branch-name #{version}" }

  it_behaves_like 'start'
end
