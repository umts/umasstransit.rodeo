# frozen_string_literal: true

require 'rails_helper'
describe Maneuver do
  describe 'previous participant' do
    let!(:maneuver) { create :maneuver }
    let!(:record1) { create :maneuver_participant, maneuver: maneuver }
    let!(:record2) { create :maneuver_participant, maneuver: maneuver }
    it 'finds previous participant' do
      actual = record2.participant.number
      expect(maneuver.previous_participant(actual)).to eql record1.participant
    end
    it 'finds previous participant with no argument' do
      expect(maneuver.previous_participant).to eql record2.participant
    end
  end
  describe 'next participant' do
    let!(:maneuver) { create :maneuver }
    let!(:record1) { create :maneuver_participant, maneuver: maneuver }
    let!(:record2) { create :maneuver_participant, maneuver: maneuver }
    it 'finds the next participant' do
      actual = record1.participant.number
      expect(maneuver.next_participant(actual)).to eql record2.participant
    end
  end
  describe 'image path' do
    it 'returns a path with maneuver name' do
      maneuver = create :maneuver, name: 'Foo'
      expect(maneuver.image_path).to eql 'maneuvers/Foo.png'
    end
  end
  describe 'grouped_obstacles' do
    context 'with the same point values and types' do
      it 'returns a hash of obstacles' do
        maneuver = create :maneuver
        obstacle1 = create :obstacle, maneuver: maneuver
        obstacle2 = create :obstacle, maneuver: maneuver,
                                      point_value: obstacle1.point_value,
                                      obstacle_type: obstacle1.obstacle_type
        expected = { [obstacle1.point_value, obstacle1.obstacle_type] =>
                    [obstacle1, obstacle2] }
        expect(maneuver.grouped_obstacles).to eql expected
      end
    end
    context 'with different point values and the same types' do
      it 'returns a hash of obstacles' do
        maneuver = create :maneuver
        obstacle1 = create :obstacle, maneuver: maneuver,
                                      point_value: 2
        obstacle2 = create :obstacle, maneuver: maneuver,
                                      point_value: 4, # diffrent than obstacle1
                                      obstacle_type: obstacle1.obstacle_type
        expected = { [obstacle1.point_value, obstacle1.obstacle_type] =>
                    [obstacle1],
                     [obstacle2.point_value, obstacle2.obstacle_type] =>
                    [obstacle2] }
        expect(maneuver.grouped_obstacles).to eql expected
      end
    end
  end
end
