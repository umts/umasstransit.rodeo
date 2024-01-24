# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'viewing the scoreboard' do
  let!(:participant) { create :participant }

  it 'shows the scores' do
    visit scoreboard_participants_path
    expect(page).to have_text participant.total_score
  end

  context 'when participant has a quiz score' do
    let!(:quiz_score) { create :quiz_score }

    before do
      participant.update quiz_score:
    end

    it 'shows the quiz score' do
      visit scoreboard_participants_path
      expect(page).to have_text quiz_score.score
    end
  end

  context 'when participant has a circle check score' do
    let!(:cc_score) { create :circle_check_score }

    before do
      participant.update circle_check_score: cc_score
    end

    it 'shows the circle check score' do
      visit scoreboard_participants_path
      expect(page).to have_text cc_score.score
    end
  end

  context 'when participant has maneuver scores' do
    let!(:mp) { create :maneuver_participant, :perfect_score, participant: }

    it 'shows the maneuver score' do
      visit scoreboard_participants_path
      expect(page).to have_text mp.score
    end
  end

  it 'shows m-dash when participant has no scores' do
    visit scoreboard_participants_path

    within('tr', text: participant.name) do
      expect(page).to have_text '—'
    end
  end
end
