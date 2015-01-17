require 'discourse_bot'
require 'vcr'

FIXTURES_PATH = File.dirname(__FILE__) + '/fixtures'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data('<API_USERNAME>') do
    JSON.load(File.read(DiscourseBot::DEFAULT_CONFIG_PATH))['api_username']
  end

  config.filter_sensitive_data('<API_PASSWORD>') do
    JSON.load(File.read(DiscourseBot::DEFAULT_CONFIG_PATH))['api_password']
  end

  config.filter_sensitive_data('<URL>') do
    JSON.load(File.read(DiscourseBot::DEFAULT_CONFIG_PATH))['url']
  end
end
