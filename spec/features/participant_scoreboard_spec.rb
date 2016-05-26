require 'rails_helper'

describe 'scoring appears properly' do
  let!(:participant) { create :participant }
  it 'when participant is intialized' do
    visit scoreboard_participants_url
    expect(page).to have_text participant.total_score.to_s
  end
  it 'when participant has a quiz score' do
    quiz_score = create :quiz_score, points_achieved: 40, total_points: 40
    participant.update quiz_score: quiz_score
    visit scoreboard_participants_url
    expect(page).to have_text participant.quiz_score.score.to_s
  end
  it 'when participant has a circle check score' do
    circle_check_score = create :circle_check_score,
                                total_defects: 5,
                                defects_found: 5
    participant.update circle_check_score: circle_check_score
    visit scoreboard_participants_url
    expect(page).to have_text participant.circle_check_score.score.to_s
  end
  it 'when participant has maneuver scores' do
    maneuver_participant = create :maneuver_participant, :perfect_score
    participant.update maneuver_participants: [maneuver_participant]
    visit scoreboard_participants_url
    expect(page).to have_text maneuver_participant.score.to_s
  end
end
