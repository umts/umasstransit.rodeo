# frozen_string_literal: true

FactoryBot.define do
  factory :circle_check_score do
    total_defects { 1 }
    defects_found { 1 }
    participant
  end
end
