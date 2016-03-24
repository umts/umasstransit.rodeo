FactoryGirl.define do
  factory :maneuver_participant do
    maneuver
    participant
    score 50
    completed_as_designed true
    reversed_direction true
  end
end
