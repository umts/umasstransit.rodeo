# frozen_string_literal: true

require 'fileutils'
ARCHIVE = Rails.env.test? ? Pathname(Dir.mktmpdir) : Rails.root.join('archive')

namespace :roadeo do
  desc 'Create a static archive of the Roadeo scoreboard'
  task archive: [:environment, 'archive:index', 'archive:assets']

  namespace :archive do
    desc 'Archive the HTML scoreboard to `/archive/index.html`'
    task index: ARCHIVE.join('index.html')

    file ARCHIVE.join('index.html') => :environment do |task|
      require 'scoreboard_renderer'

      File.write task.name, ScoreboardRenderer.render
    end

    desc 'Compile assets to `/archive/assets/`'
    task assets: :environment do
      app = Rails.application
      assets = app.assets || Sprockets::Railtie.build_environment(app)
      manifest = Sprockets::Manifest.new(assets, ARCHIVE.join('assets'))
      manifest.compile('manifest.js')
    end
  end
end
