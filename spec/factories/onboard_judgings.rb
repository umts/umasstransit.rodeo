FactoryBot.define do
  factory :onboard_judging do
    participant
    seconds_elapsed 30
    minutes_elapsed 10
  end

  trait :perfect do
    minutes_elapsed 5
    seconds_elapsed 0
    missed_turn_signals 0
    sudden_stops 0
    abrupt_turns 0
    sudden_starts 0
  end
end
