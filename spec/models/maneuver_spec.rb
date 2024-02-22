# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Maneuver do
  describe 'previous participant' do
    let!(:maneuver) { create(:maneuver) }
    let!(:record1) { create(:maneuver_participant, maneuver:) }
    let!(:record2) { create(:maneuver_participant, maneuver:) }

    it 'finds previous participant' do
      actual = record2.participant.number
      expect(maneuver.previous_participant(actual)).to eql record1.participant
    end

    it 'finds previous participant with no argument' do
      expect(maneuver.previous_participant).to eql record2.participant
    end
  end

  describe 'next participant' do
    let!(:maneuver) { create(:maneuver) }
    let!(:record1) { create(:maneuver_participant, maneuver:) }
    let!(:record2) { create(:maneuver_participant, maneuver:) }

    it 'finds the next participant' do
      actual = record1.participant.number
      expect(maneuver.next_participant(actual)).to eql record2.participant
    end
  end

  describe 'image path' do
    it 'returns a path with maneuver name' do
      maneuver = create(:maneuver, name: 'Foo')
      expect(maneuver.image_path).to eql 'maneuvers/Foo.png'
    end
  end

  describe 'grouped_obstacles' do
    subject(:call) { maneuver.grouped_obstacles }

    let(:maneuver) { create(:maneuver) }

    context 'with the same point values and types' do
      let(:obstacle1) do
        create(:obstacle, maneuver:, point_value: 3, obstacle_type: 'cow')
      end
      let!(:obstacle2) { obstacle1.dup.tap(&:save) }

      it 'returns a hash of obstacles' do
        expect(call).to eq({ [3, 'cow'] => [obstacle1, obstacle2] })
      end
    end

    context 'with different point values and the same types' do
      let(:obstacle1) do
        create(:obstacle, maneuver:, point_value: 2, obstacle_type: 'boulder')
      end
      let(:obstacle2) do
        create(:obstacle, maneuver:, point_value: 4, obstacle_type: 'boulder')
      end

      it 'returns a hash of obstacles' do
        expected = { [2, 'boulder'] => [obstacle1],
                     [4, 'boulder'] => [obstacle2] }
        expect(call).to eq(expected)
      end
    end
  end
end
