# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/scoreboard_publisher.rb'

RSpec.describe ManeuverParticipant do
  it_behaves_like 'a scoreboard publisher'

  describe 'score' do
    let!(:record) { create :maneuver_participant, :perfect_score }
    it 'should be a perfect score' do
      expect(record.score).to be(50)
    end

    it 'lowers by 10 for each reverse direction' do
      expect { record.update reversed_direction: 1 }
        .to change { record.score }
        .by(-10)
    end

    it 'lowers by 25 when speed target is not reached' do
      record.maneuver.update! speed_target: 25
      expect { record.update speed_achieved: false }
        .to change { record.score }
        .by(-25)
    end

    it 'lowers by 25 when made additional stops' do
      record.maneuver.update! counts_additional_stops: true
      expect { record.update made_additional_stops: true }
        .to change { record.score }
        .by(-25)
    end

    it 'lowers by 50 when not completed as designed' do
      expect { record.update completed_as_designed: false }
        .to change { record.score }
        .by(-50)
    end

    it 'lowers by the sum of each point value multiplied by count' do
      point_value = 1
      count = 1
      expect { record.update obstacles_hit: { 1 => [point_value, count] } }
        .to change { record.score }
        .by(-1)
    end

    context 'lowers by the positive difference' do
      it 'between each distance and the minimum multiplied by the multiplier' do
        minimum = 0
        distance = 1
        multiplier = 1
        expect do
          record.update distances_achieved: {
            [minimum, multiplier] => distance
          }
        end.to change { record.score }
          .by(-1)
      end
    end

    context 'lowers by 0 for negative difference' do
      it 'between each distance and the minimum multiplied by the multiplier' do
        minimum = 1
        distance = 1
        multiplier = 3
        expect do
          record.update distances_achieved: {
            [minimum, multiplier] => distance
          }
        end.to change { record.score }
          .by(0)
      end
    end
  end
end
