# frozen_string_literal: true

set :application, 'umasstransit.rodeo'
set :repo_url, 'git@github.com:umts/umasstransit.rodeo.git'
set :branch, 'main'

set :deploy_to, '/srv/rodeo/'

append :linked_files, 'config/database.yml', 'config/roadeo.yml'
append :linked_dirs, 'log', 'tmp/pids'

set :bundle_version, 4
set :passenger_restart_with_sudo, true
