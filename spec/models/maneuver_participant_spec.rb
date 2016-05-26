require 'rails_helper'
describe ManeuverParticipant do
  describe 'score' do
    let!(:record) { create :maneuver_participant, :perfect_score }
    it'should be a perfect score' do
      expect(record.score).to be(50)
    end

    it 'should go down by 10 for each reverse direction' do
      record.update! reversed_direction: 1
      expected = 50 - 10
      expect(record.score).to be expected
    end

    it 'should go down by 25 when speed target is not reached' do
      record.maneuver.update! speed_target: 25
      record.update! speed_achieved: false
      expected = 50 - 25
      expect(record.score).to be expected
    end

    it 'should go down by 25 when made additional stops' do
      record.maneuver.update! counts_additional_stops: true
      record.update! made_additional_stops: true
      expected = 50 - 25
      expect(record.score).to be expected
    end

    it 'should go down by 50 when not completed as designed' do
      record.update! completed_as_designed: false
      expected = 50 - 50
      expect(record.score).to be expected
    end

    it 'should go down by the sum of each point value multiplied by count' do
      record.update! obstacles_hit: { 1 => 1 }
      expected = 50 - 1
      expect(record.score).to be expected
    end

    context 'should go down by the positive difference' do
      it 'between each distance and the minimum multiplied by the multiplier' do
        record.update! distances_achieved: { [0, 1] => 1 }
        expected = 50 - 1
        expect(record.score).to be expected
      end
    end

    context 'should not go down by negative difference' do
      it 'between each distance and the minimum multiplied by the multiplier' do
        record.update! distances_achieved: { [1, 1] => 0 }
        expected = 50
        expect(record.score).to be expected
      end
    end
  end

  describe 'previous participant' do
    it'finds previous participant' do
      partip_1 = create :maneuver_participant
      partip_2 = create :maneuver_participant
      maneuver = create :maneuver,
                        maneuver_participants: [partip_1, partip_2]
      actual = partip_2.participant.number
      expected = partip_1.participant.id
      expect(maneuver.previous_participant(actual).id).to be expected
    end
    it'finds previous participant with no arguement' do
      partip_1 = create :maneuver_participant
      partip_2 = create :maneuver_participant
      maneuver = create :maneuver,
                        maneuver_participants: [partip_1, partip_2]
      expect(maneuver.previous_participant.id).to be partip_2.participant.id
    end
  end
end
