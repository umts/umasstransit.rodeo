FactoryGirl.define do
  factory :onboard_judging do
    user_id 1
    score 1
    seconds_elapsed 1
    missed_turn_signals 1
    missed_horn_sounds 1
    missed_flashers 1
    times_moved_with_door_open 1
    unannounced_stops 1
    sudden_stops 1
    abrupt_turns 1
    speeding false
  end
end
