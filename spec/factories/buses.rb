FactoryGirl.define do
  factory :bus do
    sequence(:number) { |n| "Bus #{n}" }
  end
end
