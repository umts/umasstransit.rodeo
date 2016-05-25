require 'rails_helper'
describe ManeuverParticipant do
  describe 'score' do
    it'score should be 22' do
      maneuver = create :maneuver_participant,
                        speed_achieved: true, obstacles_hit: { 1 => 2, 2 => 1 },
                        distances_achieved: { [1, 2] => 3 }
      expect(maneuver.score).to be(22)
    end
  end

  describe 'previous participant' do
    it'finds previous participant' do
      partip_1 = create :maneuver_participant
      partip_2 = create :maneuver_participant
      my_maneuver = create :maneuver,
                           maneuver_participants: [partip_1, partip_2]
      # binding.pry
      actual = partip_2.participant.number
      expected = partip_1.participant.id
      expect(my_maneuver.previous_participant(actual).id).to be expected
    end
    it'finds previous participant with no arguement' do
      partip_1 = create :maneuver_participant
      partip_2 = create :maneuver_participant
      my_maneuver = create :maneuver,
                           maneuver_participants: [partip_1, partip_2]
      # binding.pry
      expect(my_maneuver.previous_participant.id).to be partip_2.participant.id
    end
  end
end
