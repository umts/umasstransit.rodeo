# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'umasstransit.rodeo'
set :repo_url, 'git@github.com:umts/umasstransit.rodeo.git'
set :rails_env, :production
set :deploy_via, :copy
set :rbenv_ruby, '2.3.0'
set :linked_files, %w(config/database.yml)
server '45.55.158.215', user: 'dave', roles: [:app, :web, :db], primary: true

namespace :deploy do
  after :deploy do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      within release_path do
        execute 'rackup private_pub.ru -s thin -E production -D'
      end
    end
  end

end
