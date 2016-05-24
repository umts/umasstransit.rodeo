require 'rails_helper'

describe Participant do
  let!(:participant) { create :participant }
  let!(:maneuver) { create :maneuver }
  let!(:maneuver_participant) { create :maneuver_participant }
  describe 'has_completed?' do
    context 'participant has completed maneuver' do
      before :each do
        create :maneuver_participant, maneuver: maneuver, participant: participant
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
  describe 'total_score' do
    it'participant has correct maneuver score' do
      expected_total = participant.maneuver_score
      if participant.onboard_judging.present?
        expected_total += participant.onboard_judging.score
      end
      if participant.circle_check_score.present?
        expected_total += participant.circle_check_score.score
      end
      if participant.quiz_score.present?
        expected_total += participant.quiz_score.score
      end
      expect(participant.total_score).to eql expected_total
    end
  end
end
