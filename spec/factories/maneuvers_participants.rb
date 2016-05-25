FactoryGirl.define do
  factory :maneuver_participant do
    maneuver
    participant
    speed_achieved false
    made_additional_stops false
    completed_as_designed true
    reversed_direction 2
  end
end
