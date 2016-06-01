require 'rails_helper'
describe Maneuver do
  describe 'previous participant' do
    let!(:maneuver) { create :maneuver }
    let!(:record_1) { create :maneuver_participant, maneuver: maneuver }
    let!(:record_2) { create :maneuver_participant, maneuver: maneuver }
    it 'finds previous participant' do
      actual = record_2.participant.number
      expect(maneuver.previous_participant(actual)).to eql record_1.participant
    end
    it 'finds previous participant with no argument' do
      expect(maneuver.previous_participant.id).to be record_2.participant.id
    end
  end
  describe 'next participant' do
    let!(:maneuver) { create :maneuver }
    let!(:record_1) { create :maneuver_participant, maneuver: maneuver }
    let!(:record_2) { create :maneuver_participant, maneuver: maneuver }
    it 'finds the next participant' do
      actual = record_1.participant.number
      expect(maneuver.next_participant(actual)).to eql record_2.participant
    end
  end
  describe 'image path' do
    it 'returns a path with maneuver name' do
      maneuver = create :maneuver, name: 'Foo'
      expect(maneuver.image_path).to eql 'maneuvers/Foo.png'
    end
  end
end
