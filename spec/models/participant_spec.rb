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
    it 'should be zero when initialized' do
      expect(participant.total_score).to eql 0
    end
    it 'should increase by quiz score' do
      quiz_score = create :quiz_score
      expect { participant.update quiz_score: quiz_score }
        .to change { participant.total_score }
        .by(quiz_score.score)
    end
    it 'should increase by circle check score' do
      circle_check_score = create :circle_check_score
      expect { participant.update circle_check_score: circle_check_score }
        .to change { participant.total_score }
        .by(circle_check_score.score)
    end
    it 'should increase by onboard judging score' do
      onboard_judging = create :onboard_judging
      expect { participant.update onboard_judging: onboard_judging }
        .to change { participant.total_score }
        .by(onboard_judging.score)
    end
  end
end
