# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/scoreboard_publisher'

RSpec.describe CircleCheckScore do
  let(:participant) { create :participant }

  it_behaves_like 'a scoreboard publisher'

  describe 'score' do
    it 'has the correct value' do
      score = create :circle_check_score, participant: participant
      defect_percentage = score.defects_found / score.total_defects
      normalized_percentage = 50 * defect_percentage
      expect(score.score).to eql normalized_percentage
    end
  end
end
