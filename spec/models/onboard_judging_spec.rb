require 'rails_helper'

describe OnboardJudging do
  describe 'score' do
    context 'negative onboard judging' do
      let(:onboard_judging) { create :onboard_judging, minutes_elapsed: 11 }
      it 'allows negative scores' do
        expect(onboard_judging.score).to be < 0
      end
    end
    context 'perfect onboard judging' do
      let(:onboard_judging) do
        create :onboard_judging,
               :perfect
      end
      it 'has a score of 50' do
        expect(onboard_judging.score).to be 50
      end
    end
    it 'lowers by 20 for each missed turn signal' do
      onboard = create :onboard_judging, :perfect, missed_turn_signals: 1
      expected = 50 - 20
      expect(onboard.score).to be expected
    end
    it 'lowers by 20 for each sudden stop' do
      onboard = create :onboard_judging, :perfect, sudden_stops: 1
      expected = 50 - 20
      expect(onboard.score).to be expected
    end
    it 'lowers by 20 for each sudden start' do
      onboard = create :onboard_judging, :perfect, sudden_starts: 1
      expected = 50 - 20
      expect(onboard.score).to be expected
    end
    it 'lowers by 20 for each abrupt turn' do
      onboard = create :onboard_judging, :perfect, abrupt_turns: 1
      expected = 50 - 20
      expect(onboard.score).to be expected
    end
    it 'lowers by 1 for each second over 10 minutes and 30 seconds' do
      onboard = create :onboard_judging, :perfect, minutes_elapsed: 12
      expected = 50 - 90
      expect(onboard.score).to be expected
    end
    it 'tops out at 50 points' do
      onboard = create :onboard_judging, :perfect, minutes_elapsed: 0
      expect(onboard.score).to be 50
    end
  end
end
