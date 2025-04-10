# frozen_string_literal: true

require 'pathname'
require 'rails_helper'

RSpec.describe 'Archive tasks' do
  after do
    task.reenable
    task.prerequisite_tasks.each(&:reenable)
  end

  describe 'rake roadeo:archive:index', task: 'roadeo:archive:index' do
    let(:output) { ScoreboardRenderer.render }
    let(:index) { ARCHIVE.join('index.html') }

    it 'opens /archive/index.html' do
      task.invoke
      expect(index).to exist
    end

    it 'writes the rendered scoreboard to the index' do
      task.invoke
      expect(index.read).to eq(output)
    end
  end

  describe 'rake roadeo:archive:assets', task: 'roadeo:archive:assets' do
    let(:assets) { ARCHIVE.join('assets') }
    let(:asset_files) { assets.glob('*').map(&:to_path) }

    it 'creates the assets directory' do
      task.invoke
      expect(assets).to exist
    end

    %w[application.css application.js icon.svg favicon.ico].each do |asset|
      it "Compiles #{asset}" do
        task.invoke
        base, ext = asset.split('.', 2)
        expect(asset_files).to include(/#{base}-[0-9a-f]{64}\.#{ext}/)
      end
    end

    it 'Compiles FontAwesome' do
      task.invoke
      fontdir = assets.join('@fortawesome/fontawesome-free/webfonts')
      expect(fontdir.glob('fa-*')).to be_present
    end
  end
end
