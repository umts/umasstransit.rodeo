# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/scoreboard_publisher'

RSpec.describe ManeuverParticipant do
  it_behaves_like 'a scoreboard publisher'

  describe '.scoreboard_grouping' do
    subject(:call) { described_class.scoreboard_grouping }

    let(:maneuvers) { create_list(:maneuver, 5) }
    let(:participants) { create_list(:participant, 5) }

    before do
      participants.each do |participant|
        maneuvers.each do |maneuver|
          create(:maneuver_participant, maneuver:, participant:)
        end
      end
    end

    it { is_expected.to be_a(Hash) }

    it 'has Hash values' do
      expect(call.values).to all(be_a(Hash))
    end

    it 'is first keyed by partipant ids' do
      expect(call.keys).to match_array(participants.map(&:id))
    end

    it 'is next keyed by mareuver ids' do
      expect(call.values.first.keys).to match_array(maneuvers.map(&:id))
    end

    it 'contains maneuver participants' do
      mp = described_class.last
      expect(call.dig(mp.participant_id, mp.maneuver_id)).to eq(mp)
    end

    it 'contains all of the maneuver participants' do
      expect(call.values.map(&:values).flatten.length).to eq(described_class.count)
    end
  end

  describe '#score' do
    let!(:record) { create(:maneuver_participant, :perfect_score) }

    it 'is a perfect score' do
      expect(record.score).to be(50)
    end

    it 'lowers by 10 for each reverse direction' do
      expect { record.update reversed_direction: 1 }
        .to change(record, :score)
        .by(-10)
    end

    it 'lowers by 25 when speed target is not reached' do
      record.maneuver.update! speed_target: 25
      expect { record.update speed_achieved: false }
        .to change(record, :score)
        .by(-25)
    end

    it 'lowers by 25 when made additional stops' do
      record.maneuver.update! counts_additional_stops: true
      expect { record.update made_additional_stops: true }
        .to change(record, :score)
        .by(-25)
    end

    it 'lowers by 50 when not completed as designed' do
      expect { record.update completed_as_designed: false }
        .to change(record, :score)
        .by(-50)
    end

    it 'lowers by the sum of each point value multiplied by count' do
      point_value = 1
      count = 1
      expect { record.update obstacles_hit: { 1 => [point_value, count] } }
        .to change(record, :score)
        .by(-1)
    end

    context 'when the diference between distance and minimum is positive' do
      let :distances do
        # [min, multiplier] => distance
        { [0, 1] => 1 }
      end

      it 'lowers by that difference multiplied by the multiplier' do
        expect { record.update(distances_achieved: distances) }
          .to change(record, :score).by(-1)
      end
    end

    context 'when the difference between distance and minimum is negative' do
      let :distances do
        # [min, multiplier] => distance
        { [2, 3] => 1 }
      end

      it 'does not reduce the score' do
        expect { record.update(distances_achieved: distances) }
          .not_to change(record, :score)
      end
    end
  end
end
