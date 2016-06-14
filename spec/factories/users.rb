FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
  end

  trait :admin do
    admin true
  end

  trait :quiz_scorer do
    quiz_scorer true
  end

  trait :judge do
    judge true
  end

  trait :circle_check_scorer do
    circle_check_scorer true
  end

  trait :master_of_ceremonies do
    master_of_ceremonies true
  end
end
