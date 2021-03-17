# frozen_string_literal: true

require 'nokogiri'
require 'rails_helper'
require 'scoreboard_renderer'

RSpec.describe ScoreboardRenderer do
  describe '.render' do
    let(:participant) { create :participant }
    let(:maneuver) { create :maneuver }
    let(:output) { Nokogiri::HTML(described_class.render) }
    let(:css) { ->(*args) { output.css(*args) } }
    let(:sb) { 'table.scoreboard tbody' }
    before do
      create :maneuver_participant, maneuver: maneuver, participant: participant
    end

    it 'is an HTML document' do
      expect(output > 'html').to be_present
    end

    it 'has non-debug stylesheets' do
      stylesheets = css['head link[rel="stylesheet"]'].map { |s| s['href'] }
      expect(stylesheets).not_to include(match('debug'))
    end

    it 'has non-debug javascript' do
      js = css['script[src]'].map { |s| s['src'] }
      expect(js).not_to include(match('debug'))
    end

    it 'has no navigation buttons' do
      expect(css['nav #mainnav a']).to be_empty
    end

    it 'has a "Final Results" header' do
      expect(css['nav h1', text: 'Final Results']).to be_present
    end

    it 'has the scoreboard table' do
      expect(css[sb]).to be_present
    end

    it 'has the participants' do
      expect(css["#{sb} tr"].count).to be(1)
      expect(css["#{sb} td.participant", text: participant.name]).to be_present
    end

    it 'has the maneuvers' do
      sel = <<~CSS.squish
        #{sb} tr[data-participant-id="#{participant.id}"]
        td[data-maneuver-id="#{maneuver.id}"]
      CSS
      expect(css[sel]).to be_present
    end
  end
end
