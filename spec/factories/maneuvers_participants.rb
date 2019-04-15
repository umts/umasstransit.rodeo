# frozen_string_literal: true

FactoryBot.define do
  factory :maneuver_participant do
    maneuver
    participant
    reversed_direction { 0 }
  end

  trait :perfect_score do
    maneuver
    participant
    reversed_direction { 0 }
    speed_achieved { true }
    completed_as_designed { true }
    made_additional_stops { false }
  end
end
