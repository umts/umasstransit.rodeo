# frozen_string_literal: true

require 'rails_helper'

describe 'viewing the scoreboard' do
  let(:mp) { create :maneuver_participant }
  let!(:participant) { mp.participant }

  context 'while not logged in' do
    before :each do
        visit scoreboard_participants_path
        @row = find('tr', text: participant.name)
    end
    it 'shows participants and scores' do
      expect(page).to have_text mp.participant.name
      expect(@row).to have_text mp.score
    end
    it 'does not provide any links to edit' do
      expect(@row).to have_no_link
    end
  end

  context 'while not an admin' do
    before :each do
        visit scoreboard_participants_path
        @row = find('tr', text: participant.name)
    end
    it 'shows participants and scores' do
      expect(page).to have_text mp.participant.name
      expect(@row).to have_text mp.score
    end
    it 'does not provide any links to edit' do
      expect(@row).to have_no_link
    end
  end

  context 'while an admin' do
    it 'provides links to edit' do
      when_current_user_is :admin
      visit scoreboard_participants_path
      row = find('tr', text: participant.name)

      # The maneuver they've completed
      expect(row).to have_link mp.score
      # At least one uncompleted score
      expect(row).to have_link(text: '—')
    end
  end
end
