# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/normalized_score'
require_relative 'concerns/scoreboard_publisher'

RSpec.describe QuizScore do
  subject(:score) do
    create :quiz_score, total_points: 100, points_achieved: 96, participant:
  end

  let(:expected_score) { 48 }
  let!(:participant) { create :participant }

  it_behaves_like 'a normalized score'
  it_behaves_like 'a scoreboard publisher'
end
