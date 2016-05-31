require 'rails_helper'
describe ManeuverParticipant do
  describe 'score' do
    let!(:record) { create :maneuver_participant, :perfect_score }
    it'should be a perfect score' do
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
      expect { record.update obstacles_hit: { 1 => 1 } }
        .to change { record.score }
        .by(-1)
    end

    context 'lowers by the positive difference' do
      it 'between each distance and the minimum multiplied by the multiplier' do
        expect { record.update distances_achieved: { [0, 1] => 1 } }
          .to change { record.score }
          .by(-1)
      end
    end

    context 'lowers by negative difference' do
      it 'between each distance and the minimum multiplied by the multiplier' do
        expect { record.update distances_achieved: { [1, 1] => 0 } }
          .to change { record.score }
          .by(0)
      end
    end
  end
end
