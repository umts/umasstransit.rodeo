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
  #   describe 'total_score' do
  #     it 'should equal maneuver score' do
  #       participant = create :participant, :total_score
  #       expect(participant.total_score).to eql participant.maneuver_score
  #       binding.pry
  #     end
  #     it 'should increase by onboard judging score' do
  #     end
  #
  #     it 'should increase by circle check score' do
  #     end
  #
  #     it 'should increase by quiz score' do
  #     end
  #   end
end
