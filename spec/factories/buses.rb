# frozen_string_literal: true

FactoryBot.define do
  factory :bus do
    sequence(:number) { |n| "Bus #{n}" }
  end
end
