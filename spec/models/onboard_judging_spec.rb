# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/scoreboard_publisher'

RSpec.describe OnboardJudging do
  it_behaves_like 'a scoreboard publisher'

  describe 'score' do
    context 'with a high enough penalty' do
      let(:onboard_judging) { create :onboard_judging, minutes_elapsed: 11 }

      it 'can be negative' do
        expect(onboard_judging.score).to be_negative
      end
    end

    context 'with a perfect onboard judging' do
      let(:onboard_judging) { create :onboard_judging, :perfect }

      it 'has a score of 50' do
        expect(onboard_judging.score).to be 50
      end
    end

    it 'lowers by 1 for each missed turn signal' do
      onboard = create :onboard_judging, :perfect, missed_turn_signals: 1
      expect(onboard.score).to be(50 - 1)
    end

    it 'lowers by 3 for each missed horn sound' do
      onboard = create :onboard_judging, :perfect, missed_horn_sounds: 1
      expect(onboard.score).to be(50 - 3)
    end

    it 'lowers by 3 for each missed flashers' do
      onboard = create :onboard_judging, :perfect, missed_flashers: 1
      expect(onboard.score).to be(50 - 3)
    end

    it 'lowers by 3 for each time moved with door open' do
      onboard = create :onboard_judging, :perfect, times_moved_with_door_open: 1
      expect(onboard.score).to be(50 - 3)
    end

    it 'lowers by 10 for each unannounced stop' do
      onboard = create :onboard_judging, :perfect, unannounced_stops: 1
      expect(onboard.score).to be(50 - 10)
    end

    it 'lowers by 1 for each sudden stop' do
      onboard = create :onboard_judging, :perfect, sudden_stops: 1
      expect(onboard.score).to be(50 - 1)
    end

    it 'lowers by 1 for each sudden start' do
      onboard = create :onboard_judging, :perfect, sudden_starts: 1
      expect(onboard.score).to be(50 - 1)
    end

    it 'lowers by 1 for each abrupt turn' do
      onboard = create :onboard_judging, :perfect, abrupt_turns: 1
      expect(onboard.score).to be(50 - 1)
    end

    it 'lowers by 60 for each minute over 7' do
      onboard = create :onboard_judging, :perfect, minutes_elapsed: 7 + 1
      expect(onboard.score).to be(50 - 60)
    end

    it 'lowers by 1 for each second over 7 minutes' do
      onboard = create :onboard_judging, :perfect, minutes_elapsed: 7,
                                                   seconds_elapsed: 1
      expect(onboard.score).to be(50 - 1)
    end

    it 'does not lower for times under 7 minutes' do
      onboard = create :onboard_judging, :perfect, minutes_elapsed: 1
      expect(onboard.score).to be 50
    end
  end
end
