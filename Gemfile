source 'https://rubygems.org'

gem 'coffee-rails'
gem 'certified'
gem 'devise', '~> 4.0.0'
gem 'factory_bot_rails'
gem 'ffaker'
gem 'haml'
gem 'haml-rails'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'mysql2', '~> 0.4.10'
gem 'paper_trail'
gem 'private_pub'
gem 'rails', '~> 5.0.7'
gem 'rubocop'
gem 'sassc-rails'
gem 'spring'
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

group :test do
  gem 'capybara'
  gem 'codeclimate-test-reporter', '~> 1.0'
  gem 'mocha'
  gem 'rack_session_access'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'simplecov'
  gem 'timecop'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry-byebug'
  gem 'rb-readline', require: false
end
