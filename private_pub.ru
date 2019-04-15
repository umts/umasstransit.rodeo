# frozen_string_literal: true

# Run with: rackup private_pub.ru -s thin -E production
require 'bundler/setup'
require 'yaml'
require 'faye'
require 'private_pub'

Faye::WebSocket.load_adapter('thin')

config_file = File.expand_path('config/private_pub.yml', __dir__)
environment = ENV['RAILS_ENV'] || 'development'
PrivatePub.load_config(config_file, environment)
run PrivatePub.faye_app
