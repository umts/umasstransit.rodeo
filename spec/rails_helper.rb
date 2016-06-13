ENV['RAILS_ENV'] ||= 'test'
require 'factory_girl_rails'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'spec_helper'
require 'capybara/rails'
require 'rack_session_access/capybara'

ActiveRecord::Migration.maintain_test_schema!
RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true
  config.include Warden::Test::Helpers, type: :feature
  config.before(:suite) { Warden.test_mode! }
end
