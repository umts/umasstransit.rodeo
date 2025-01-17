# frozen_string_literal: true

source 'https://rubygems.org'
ruby file: '.ruby-version'

gem 'bootsnap'
gem 'bootstrap', '~> 4.6.2'
gem 'certified'
gem 'coffee-rails'
# TODO: remove when on Rails 7.1
gem 'concurrent-ruby', '1.3.5'
gem 'devise', '~> 4.9'
gem 'factory_bot_rails'
gem 'haml'
gem 'haml-rails'
gem 'irb'
# TODO: remove when on Rails 7.1
gem 'logger'
# TODO: remove when on Rails 7.1
gem 'mutex_m'
gem 'mysql2', '~> 0.5.6'
gem 'openssl'
gem 'paper_trail'
gem 'puma'
gem 'rails', '~> 7.0.8'
gem 'sassc-rails'
gem 'sprockets-rails'
gem 'thruster'
gem 'uglifier'

group :production do
  gem 'exception_notification'
  gem 'redis', '~> 5.3'
end

group :development do
  gem 'bcrypt_pbkdf', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 3.19', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-pending', require: false
  gem 'capistrano-rails', require: false
  gem 'dockerfile-rails'
  gem 'ed25519', require: false
  gem 'listen'
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'action-cable-testing'
  gem 'capybara'
  gem 'rack_session_access'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'simplecov'
  gem 'timecop'
end

group :development, :test do
  gem 'debug'
  gem 'faker'
  gem 'rb-readline', require: false
end
