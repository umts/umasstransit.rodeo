# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/scoreboard_publisher.rb'

RSpec.describe QuizScore do
  it_behaves_like 'a scoreboard publisher'

  let(:participant) { create :participant }
  describe 'score' do
    it 'score should have the correct value' do
      score = create :quiz_score, participant: participant
      quiz_percentage = (score.points_achieved / score.total_points).round 1
      normalized_percentage = 50 * quiz_percentage
      expect(score.score).to eql normalized_percentage
    end
  end
end
