FactoryBot.define do
  factory :onboard_judging do
    participant
    seconds_elapsed { 0 }
    minutes_elapsed { 7 }
  end

  trait :perfect do
    minutes_elapsed { 5 }
    seconds_elapsed { 0 }
    missed_turn_signals { 0 }
    missed_horn_sounds { 0 }
    missed_flashers { 0 }
    times_moved_with_door_open { 0 }
    unannounced_stops { 0 }
    sudden_stops { 0 }
    abrupt_turns { 0 }
    speeding { false }
    sudden_starts { 0 }
  end
end
