FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    approved { true }
  end

  trait :admin do
    admin { true }
  end

  trait :quiz_scorer do
    quiz_scorer { true }
  end

  trait :judge do
    judge { true }
  end

  trait :circle_check_scorer do
    circle_check_scorer { true }
  end

  trait :master_of_ceremonies do
    master_of_ceremonies { true }
  end

  # Not strictly necessary since this is also the factory value,
  # but this is implemented for clarity of tests.
  trait :approved do
    approved { true }
  end

  trait :unapproved do
    approved { false }
  end
end
