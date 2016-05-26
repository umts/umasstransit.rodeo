FactoryGirl.define do
  factory :participant do
    sequence(:name) { |n| "Participant #{n}" }
    sequence :number
    bus
  end

  trait :total_score do
    sequence(:name) { |n| "Participant #{n}" }
    sequence :number
    bus
    quiz_score
    circle_check_score
    onboard_judging
    maneuver
  end
end
