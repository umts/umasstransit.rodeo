# frozen_string_literal: true

FactoryBot.define do
  factory :maneuver do
    sequence(:name) { |n| "Maneuver #{n}" }
    sequence :sequence_number
  end
end
