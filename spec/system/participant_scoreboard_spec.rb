# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'scoring appears properly' do
  let!(:participant) { create :participant }
  it 'when participant is intialized' do
    visit scoreboard_participants_path
    expect(page).to have_text participant.total_score
  end
  it 'when participant has a quiz score' do
    quiz_score = create :quiz_score
    participant.update quiz_score: quiz_score
    visit scoreboard_participants_path
    expect(page).to have_text quiz_score.score
  end
  it 'when participant has a circle check score' do
    circle_check_score = create :circle_check_score
    participant.update circle_check_score: circle_check_score
    visit scoreboard_participants_path
    expect(page).to have_text circle_check_score.score
  end
  it 'when participant has maneuver scores' do
    maneuver_participant = create :maneuver_participant, :perfect_score,
                                  participant: participant
    visit scoreboard_participants_path
    expect(page).to have_text maneuver_participant.score
  end
  it 'shows m-dash when participant has no scores' do
    visit scoreboard_participants_path
    expect(page).to have_text '—'
  end
end
