require 'rails_helper'

describe Participant do
  let!(:participant) { create :participant }
  describe 'has_completed?' do
    let!(:maneuver) { create :maneuver }
    let!(:maneuver_participant) { create :maneuver_participant }
    context 'participant has completed maneuver' do
      before :each do
        create :maneuver_participant, maneuver: maneuver,
                                      participant: participant
      end
      it 'returns true' do
        expect(participant.has_completed?(maneuver)).to be true
      end
    end
    context 'participant has not completed manuever' do
      it 'returns false' do
        expect(participant.has_completed?(maneuver)).to be false
      end
    end
  end
  describe 'total score' do
    it 'should be zero' do
      expect(participant.total_score).to eql 0
    end
    it 'should increase by 40 from quiz score' do
      quiz_score = create :quiz_score, points_achieved: 80, total_points: 100
      expect { participant.update quiz_score: quiz_score }
        .to change { participant.total_score }
        .by(40)
    end
    it 'should increase by 50 from circle check score' do
      circle_check_score = create :circle_check_score, total_defects: 5, defects_found: 5
      expect { participant.update circle_check_score: circle_check_score }
        .to change { participant.total_score }
        .by(50)
    end
    it 'should increase by 50 from onboard judging score' do
      onboard_judging = create :onboard_judging
      expect { participant.update onboard_judging: onboard_judging }
        .to change { participant.total_score }
        .by(50)
    end
  end
end
