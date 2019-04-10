FactoryBot.define do
  factory :quiz_score do
    points_achieved { 100 }
    total_points { 100 }
    participant
  end
end
