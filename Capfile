%w(setup deploy bundler rbenv passenger rails rails/migrations).each { |r| require "capistrano/#{r}" }
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
