class WheelchairManeuver < ActiveRecord::Base
  has_paper_trail

  belongs_to :participant
  validates :participant, uniqueness: true
  before_validation :set_score

  CHECKS = { 
    loading: { 
      first_ask_to_touch: 'ask the passenger if they can touch the wheelchair?',
      first_check_brakes_on: 'check wheelchair brakes?',
      offer_seatbelt: 'offer the seatbelt?',
      securement: 'attach 4 points of securement?',
      ask_if_ready: 'ask if you are ready to go before moving?'
    },
    offloading: {
      remove_restraints: 'remove all restraints from the floor?',
      check_brakes_off: 'check wheelchair brakes are off?',
      second_ask_to_touch: 'ask if they can touch the wheelchair?',
      second_check_brakes_on: 'check wheelchair brakes are on on lift?',
      ask_if_all_set_on_lift: 'ask if you are all set on the lift?' 
    }
  }
  POINT_VALUES = {
    # points to remove if participant did NOT do the thing
    first_ask_to_touch: 10,
    first_check_brakes_on: 15,
    offer_seatbelt: 15,
    securement: 50,
    ask_if_ready: 10,
    remove_restraints: 50,
    check_brakes_off: 15,
    second_ask_to_touch: 10,
    second_check_brakes_on: 15,
    ask_if_all_set_on_lift: 10
  }

  def set_score
    score = 200
    POINT_VALUES.each do |key, value|
      if self.send(key) == false
        score -= value
      end
    end
    assign_attributes score: score
  end
  
end
