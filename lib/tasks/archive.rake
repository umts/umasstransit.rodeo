# frozen_string_literal: true

require 'fileutils'
ARCHIVE = Rails.root.join('archive')

namespace :roadeo do
  task archive: [:environment, 'archive:index', 'archive:assets']

  namespace :archive do
    task index: ARCHIVE.join('index.html')

    file ARCHIVE.join('index.html') => :environment do |t|
      require 'scoreboard_renderer'

      File.open(t.name, 'w') do |f|
        f.write ScoreboardRenderer.render
      end
    end

    task :assets => [:environment, 'assets:precompile'] do
      FileUtils.cp_r(Rails.root.join('public/assets'), ARCHIVE)
      Rake::Task['assets:clobber'].invoke unless Rails.env.production?
    end
  end
end
