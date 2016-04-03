# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'umasstransit.rodeo'
set :repo_url, 'git@github.com:umts/umasstransit.rodeo.git'
set :rails_env, :production
set :deploy_via, :copy
set :rbenv_ruby, '2.3.0'
set :linked_files, %w(config/database.yml config/private_pub_thin.yml)
set :linked_dirs, %w(config/certs)
server '45.55.158.215', user: 'dave', roles: [:app, :web, :db], primary: true
