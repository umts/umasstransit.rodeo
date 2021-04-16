# frozen_string_literal: true

require 'fileutils'
ARCHIVE = Rails.env.test? ? Pathname(Dir.mktmpdir) : Rails.root.join('archive')

namespace :roadeo do
  desc 'Create a static archive of the Roadeo scoreboard'
  task archive: [:environment, 'archive:index', 'archive:assets']

  namespace :archive do
    desc 'Archive the HTML scoreboard to `/archive/index.html`'
    task index: ARCHIVE.join('index.html')

    file ARCHIVE.join('index.html') => :environment do |t|
      require 'scoreboard_renderer'

      File.open(t.name, 'w') do |f|
        f.write ScoreboardRenderer.render
      end
    end

    desc 'Compile assets and add them to `/archive/assets/`'
    task assets: [:environment, 'assets:precompile'] do
      FileUtils.cp_r(Rails.root.join('public/assets'), ARCHIVE)
      Rake::Task['assets:clobber'].invoke unless Rails.env.production?
    end
  end
end
