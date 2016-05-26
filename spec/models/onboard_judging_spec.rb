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
    it 'lowers by 1 for each missed turn signal' do
      onboard = create :onboard_judging, :perfect, missed_turn_signals: 1
      expected = 50 - 1
      expect(onboard.score).to be expected
    end
    it 'lowers by 3 for each missed horn sound' do
      onboard = create :onboard_judging, :perfect, missed_horn_sounds: 1
      expected = 50 - 3
      expect(onboard.score).to be expected
    end
    it 'lowers by 3 for each missed flashers' do
      onboard = create :onboard_judging, :perfect, missed_flashers: 1
      expected = 50 - 3
      expect(onboard.score).to be expected
    end
    it 'lowers by 3 for each time moved with door open' do
      onboard = create :onboard_judging, :perfect, times_moved_with_door_open: 1
      expected = 50 - 3
      expect(onboard.score).to be expected
    end
    it 'lowers by 10 for each unannounced stop' do
      onboard = create :onboard_judging, :perfect, unannounced_stops: 1
      expected = 50 - 10
      expect(onboard.score).to be expected
    end
    it 'lowers by 1 for each sudden stop' do
      onboard = create :onboard_judging, :perfect, sudden_stops: 1
      expected = 50 - 1
      expect(onboard.score).to be expected
    end
    it 'lowers by 1 for each sudden start' do
      onboard = create :onboard_judging, :perfect, sudden_starts: 1
      expected = 50 - 1
      expect(onboard.score).to be expected
    end
    it 'lowers by 1 for each abrupt turn' do
      onboard = create :onboard_judging, :perfect, abrupt_turns: 1
      expected = 50 - 1
      expect(onboard.score).to be expected
    end
    it 'lowers by 60 for each minute elapsed' do
      onboard = create :onboard_judging, :perfect, minutes_elapsed: 8
      expected = 50 - 60
      expect(onboard.score).to be expected
    end
    it 'lowers by 1 for minutes over seven and each second elapsed' do
      onboard = create :onboard_judging, :perfect, minutes_elapsed: 7,
                                                   seconds_elapsed: 1
      expected = 50 - 1
      expect(onboard.score).to be expected
    end
    it 'tops out at 50 points' do
      onboard = create :onboard_judging, :perfect, minutes_elapsed: 0
      expect(onboard.score).to be 50
    end
  end
end
