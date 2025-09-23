# frozen_string_literal: true

source 'https://rubygems.org'
ruby file: '.ruby-version'

gem 'bootsnap'
gem 'certified'
gem 'cssbundling-rails'
gem 'devise', '~> 4.9'
gem 'factory_bot_rails'
gem 'haml'
gem 'haml-rails'
gem 'irb'
gem 'jbuilder'
gem 'openssl'
gem 'paper_trail'
gem 'puma'
gem 'rails', '~> 8.0.2'
gem 'solid_cable'
gem 'sprockets-rails'
gem 'terser'
gem 'thruster'
gem 'trilogy'

group :production do
  gem 'exception_notification'
end

group :development do
  gem 'bcrypt_pbkdf', require: false
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'capistrano', '~> 3.19', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-pending', require: false
  gem 'capistrano-rails', require: false
  gem 'dockerfile-rails'
  gem 'ed25519', require: false
  gem 'haml_lint', require: false
  gem 'listen'
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-capybara', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'rubocop-rspec_rails', require: false
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
end

group :development, :test do
  gem 'debug'
  gem 'faker'
  gem 'rb-readline', require: false
end
