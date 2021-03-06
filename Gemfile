# frozen_string_literal: true

source 'https://rubygems.org'
ruby IO.read(File.expand_path('.ruby-version', __dir__)).strip

gem 'bootsnap'
gem 'bootstrap', '~> 4.3.1'
gem 'certified'
gem 'coffee-rails'
gem 'devise', '~> 4.6'
gem 'haml'
gem 'haml-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'mysql2', '~> 0.5.2'
gem 'openssl'
gem 'paper_trail'
gem 'puma'
gem 'rails', '~> 6.1.3'
gem 'sassc-rails'
gem 'uglifier'
gem 'underscore-rails'

group :production do
  gem 'exception_notification'
  gem 'redis', '~> 3.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 3.14', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-pending', require: false
  gem 'capistrano-rails', require: false
  gem 'listen', '~> 3.0.5'
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'action-cable-testing'
  gem 'capybara'
  gem 'rack_session_access'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'timecop'
  gem 'webdrivers'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'pry-byebug'
  gem 'rb-readline', require: false
end
