source 'https://rubygems.org'

gem 'coffee-rails'
gem 'certified'
gem 'devise', '~> 3.5'
gem 'factory_bot_rails'
gem 'ffaker'
gem 'haml'
gem 'haml-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'mysql2', '~> 0.4.10'
gem 'paper_trail'
gem 'private_pub'
gem 'rails', '~> 4.2'
gem 'rubocop'
gem 'sassc-rails'
gem 'thin'
gem 'uglifier'
gem 'underscore-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap'
  gem 'rails-assets-codedance--jquery.areyousure'
end

group :production do
  gem 'exception_notification'
end

group :development do
  gem 'capistrano', '~> 3.4.0', require: false
  gem 'capistrano-pending', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-passenger', require: false
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'capybara'
  gem 'codeclimate-test-reporter', '~> 1.0'
  gem 'mocha'
  gem 'pry-byebug'
  gem 'rack_session_access'
  gem 'rb-readline', require: false
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'timecop'
end
