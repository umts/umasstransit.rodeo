# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/scoreboard_publisher'

RSpec.describe QuizScore do
  subject(:score) do
    create :quiz_score, total_points: 100, points_achieved: 96, participant: participant
  end

  let(:participant) { create :participant }

  it_behaves_like 'a scoreboard publisher'

  describe '.with_scores' do
    subject(:call) { described_class.select('*').with_scores }

    it 'includes the calculated column' do
      expect(call.find(score.id).attributes).to include('quiz_score')
    end

    it 'calculates the score correctly' do
      expect(call.find(score.id).quiz_score).to eq 48
    end
  end

  describe 'score' do
    it 'has the correct value' do
      expect(score.score).to eq 48
    end

    it 'can get the calculation from the database' do
      allow(described_class).to receive(:with_scores)
        .and_return(described_class.select('23 AS quiz_score'))

      score_from_db = described_class.select('*').with_scores.find(score.id)
      expect(score_from_db.score).to eq(23)
    end
  end
end
