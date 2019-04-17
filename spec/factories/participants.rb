# frozen_string_literal: true

FactoryBot.define do
  factory :participant do
    sequence(:name) { |n| "Participant #{n}" }
    sequence :number
    bus
  end
end
