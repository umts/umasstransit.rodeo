# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Maneuver do
  describe 'previous participant' do
    let!(:maneuver) { create(:maneuver) }
    let!(:previous_record) { create(:maneuver_participant, maneuver:) }
    let!(:record) { create(:maneuver_participant, maneuver:) }

    it 'finds previous participant' do
      actual = record.participant.number
      expect(maneuver.previous_participant(actual)).to eql previous_record.participant
    end

    it 'finds previous participant with no argument' do
      expect(maneuver.previous_participant).to eql record.participant
    end
  end

  describe 'next participant' do
    let!(:maneuver) { create(:maneuver) }
    let!(:record) { create(:maneuver_participant, maneuver:) }
    let!(:next_record) { create(:maneuver_participant, maneuver:) }

    it 'finds the next participant' do
      actual = record.participant.number
      expect(maneuver.next_participant(actual)).to eql next_record.participant
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
      let(:obstacle) do
        create(:obstacle, maneuver:, point_value: 3, obstacle_type: 'cow')
      end
      let!(:duplicate_obstacle) { obstacle.dup.tap(&:save) }

      it 'returns a hash of obstacles' do
        expect(call).to eq({ [3, 'cow'] => [obstacle, duplicate_obstacle] })
      end
    end

    context 'with different point values and the same types' do
      let(:obstacle) do
        create(:obstacle, maneuver:, point_value: 2, obstacle_type: 'boulder')
      end
      let(:different_score_obsticle) do
        create(:obstacle, maneuver:, point_value: 4, obstacle_type: 'boulder')
      end

      it 'returns a hash of obstacles' do
        expected = { [2, 'boulder'] => [obstacle],
                     [4, 'boulder'] => [different_score_obsticle] }
        expect(call).to eq(expected)
      end
    end
  end
end
