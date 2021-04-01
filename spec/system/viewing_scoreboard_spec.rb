# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'they are not allowed to edit' do
  it 'shows participants and scores' do
    expect(page).to have_text mp.participant.name
    expect(row).to have_text mp.score
  end

  it 'does not provide any links to edit' do
    expect(row).to have_no_link
  end
end

RSpec.describe 'viewing the scoreboard' do
  let(:mp) { create :maneuver_participant }
  let!(:participant) { mp.participant }
  let(:row) { find('tr', text: participant.name) }

  context 'while not logged in' do
    before do
      when_current_user_is nil
      visit scoreboard_participants_path
    end

    include_examples 'they are not allowed to edit'
  end

  context 'while not an admin' do
    before do
      when_current_user_is :anyone
      visit scoreboard_participants_path
    end

    include_examples 'they are not allowed to edit'
  end

  context 'while an admin' do
    it 'provides links to edit' do
      when_current_user_is :admin
      visit scoreboard_participants_path

      # The maneuver they've completed
      expect(row).to have_link(text: mp.score)
      # At least one uncompleted score
      expect(row).to have_link(text: '—')
    end
  end
end
