# frozen_string_literal: true

# config valid only for current version of Capistrano
lock '~> 3.19'

set :application, 'umasstransit.rodeo'
set :repo_url, 'git@github.com:umts/umasstransit.rodeo.git'
set :branch, 'main'

set :deploy_to, '/srv/rodeo/'

append :linked_files, 'config/database.yml', 'config/roadeo.yml'

append :linked_dirs, 'log', 'tmp/pids', 'node_modules'
