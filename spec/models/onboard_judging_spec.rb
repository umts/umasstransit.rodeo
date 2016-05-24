require 'rails_helper'

RSpec.describe OnboardJudging, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe OnboardJudging do
  let!(:onboard_judging) { create :onboard_judging }
  describe 'set_score' do
    it 'private method is run' do
      expected_score = 50
      expected_score -= onboard_judging.missed_turn_signals
      expected_score -= 3 * onboard_judging.missed_horn_sounds
      expected_score -= 3 * onboard_judging.missed_flashers
      expected_score -= 3 * onboard_judging.times_moved_with_door_open
      expected_score -= 10 * onboard_judging.unannounced_stops
      expected_score -= onboard_judging.sudden_stops
      expected_score -= onboard_judging.sudden_starts
      expected_score -= onboard_judging.abrupt_turns
      if onboard_judging.minutes_elapsed >= 7
        expected_score -= 60 * (onboard_judging.minutes_elapsed - 7)
        expected_score -= onboard_judging.seconds_elapsed
      end
      expect(onboard_judging.score).to eql expected_score
    end
  end
end
