# config valid only for current version of Capistrano
lock '~> 3.4.0'

set :application, 'umasstransit.rodeo'
set :repo_url, 'git@github.com:umts/umasstransit.rodeo.git'


# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/rodeo/'

set :linked_files, fetch(:linked_files, []).push(
  'config/database.yml',
  'config/faye.yml'
)

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids'
)
