# frozen_string_literal: true

require 'factory_bot'
require 'simplecov'

Dir[Pathname(__dir__).join('support', '**', '*.rb')].each { |f| require f }

SimpleCov.start 'rails'

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.example_status_persistence_file_path =
    Pathname(__dir__).join('examples.txt')

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.before :all do
    FactoryBot.reload
  end
  config.include FactoryBot::Syntax::Methods

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
