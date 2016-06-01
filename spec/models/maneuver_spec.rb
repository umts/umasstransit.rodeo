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
  describe 'grouped_obstacles' do
    context 'with the same point values' do
      it 'returns an array of obstacles' do
        maneuver = create :maneuver
        obstacle_1 = create :obstacle, maneuver: maneuver
        obstacle_2 = create :obstacle, maneuver: maneuver 
        expected = { [obstacle_1.point_value, obstacle_1.obstacle_type] =>
                    [obstacle_1, obstacle_2] }
        expect(maneuver.grouped_obstacles).to eql expected
      end
    end
    context 'with different point values' do
      it 'returns an array of obstacles' do
        maneuver = create :maneuver
        obstacle_1 = create :obstacle, maneuver: maneuver, point_value: 2
        obstacle_2 = create :obstacle, maneuver: maneuver, point_value: 4
        expected = { [obstacle_1.point_value, obstacle_1.obstacle_type] =>
                    [obstacle_1],
                    [obstacle_2.point_value, obstacle_2.obstacle_type] =>
                    [obstacle_2] }
        expect(maneuver.grouped_obstacles).to eql expected
      end
    end
  end
end
