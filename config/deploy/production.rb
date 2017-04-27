remote_user = Net::SSH::Config.for('umasstransit.rodeo')[:user] || ENV['USER']
server 'umasstransit.rodeo',
       roles: %w(app db web),
       user: remote_user
set :tmp_dir, "/tmp/#{remote_user}"
