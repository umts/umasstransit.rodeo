# frozen_string_literal: true

namespace :roadeo do
  desc 'Reset the roadeo for a new year (passing an argument will also destroy versions).'
  task :reset, [:discard_versions] => :environment do |_, args|
    discard_versions = args[:discard_versions].present?

    puts 'This will destroy all participants and scores.'
    puts 'It will also destroy past versions of participants and scores.' if discard_versions
    print 'Type "YES" if you\'re sure: '
    input = $stdin.gets.strip
    next unless input == 'YES'

    Bus.destroy_all
    Participant.find_each(&:destroy)
    User.where.not(admin: true).find_each(&:destroy)
    Settings.instance.update!(scores_locked: true)

    next unless discard_versions

    PaperTrail::Version.where.not(item_type: 'User').find_each(&:destroy)
  end
end
