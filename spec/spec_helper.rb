require 'bundler/setup'
require 'open3'
require 'papa'
require 'papa/cli/sandbox'
require 'papa/sandbox/generate'
require 'papa/output'
Dir['./spec/support/*.rb'].sort.each { |f| require f }
Dir['./spec/support/shared/*.rb'].sort.each { |f| require f }

RSpec.configure do |config|
  PROJECT_ROOT = File.expand_path(File.dirname(__dir__), '../../..')

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Helpers
end
