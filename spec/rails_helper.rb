# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

require 'spec_helper'

require 'capybara/rails'
require 'factory_bot_rails'
require 'rack_session_access/capybara'
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!
RSpec.configure do |config|
  config.disable_monkey_patching!
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers, type: :system

  config.define_derived_metadata(file_path: %r{/spec/tasks/}) do |metadata|
    metadata[:type] = :task
  end
  config.include TaskExampleGroup, type: :task

  config.before(:suite) do
    Warden.test_mode!
    Rails.application.load_tasks
    Settings.instance.update!(scores_locked: false)
  end

  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end
end
