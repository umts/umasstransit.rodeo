# frozen_string_literal: true

%w[setup deploy bundler rails passenger pending yarn].each do |lib|
  require "capistrano/#{lib}"
end

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
