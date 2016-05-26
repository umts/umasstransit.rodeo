require 'rails_helper'

describe Participant do
  let!(:participant) { create :participant }
  let!(:maneuver) { create :maneuver }
  let!(:maneuver_participant) { create :maneuver_participant }
  describe 'has_completed?' do
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
end
