require 'rails_helper'

describe QuizScore do
  let(:participant) { create :participant }
  it 'score should have the correct value' do
    points_achieved = 50.0
    total_points = 100.0
    quiz = create :quiz_score, participant: participant,
                               points_achieved: points_achieved,
                               total_points: total_points
    expect(quiz.score).to eql (50 / total_points * points_achieved).round 1
  end
end
