require 'rails_helper'

describe WheelchairManeuver do
  describe 'set_score' do
    let!(:wheelchair_maneuver) do
      create :wheelchair_maneuver,
        first_ask_to_touch: true,
        first_check_brakes_on: false, # 15
        offer_seatbelt: true,
        securement: true,
        ask_if_ready: false, # 10
        remove_restraints: false, # 50
        check_brakes_off: true,
        second_ask_to_touch: false, # 10
        second_check_brakes_on: true,
        ask_if_all_set_on_lift: false # 10
    end
    it 'removes the number of points corresponding to each false attribute' do
      expect(wheelchair_maneuver.score).to eql (200 - 15 - 10 - 50 - 10 - 10)
    end
  end
end
