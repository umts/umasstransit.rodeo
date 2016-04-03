# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'umasstransit.rodeo'
set :repo_url, 'git@github.com:umts/umasstransit.rodeo.git'
set :rails_env, :production
set :deploy_via, :copy
set :rbenv_ruby, '2.3.0'
set :linked_files, %w(config/database.yml)
server '45.55.158.215', user: 'dave', roles: [:app, :web, :db], primary: true

namespace :faye do
  task :start do
    run "cd #{deploy_to}/current && bundle exec rackup private_pub.ru -s thin -E production -D"
  end
  task :stop do
    run "kill `cat #{deploy_to}/shared/pids/faye.pid` || true"
  end
end
before 'deploy:update_code', 'faye:stop'
after 'deploy:finalize_update', 'faye: start'


namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
