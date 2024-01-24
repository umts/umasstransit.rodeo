# frozen_string_literal: true

namespace :roadeo do
  desc 'Reset the roadeo for a new year'
  task reset: :environment do
    puts 'This will destroy all participants and scores.'
    print 'Type "YES" if you\'re sure: '
    input = $stdin.gets.strip
    next unless input == 'YES'

    Bus.destroy_all
    Participant.find_each(&:destroy)
    User.where.not(admin: true).find_each(&:destroy)
  end
end
