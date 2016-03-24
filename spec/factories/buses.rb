FactoryGirl.define do
  factory :bus do
    sequence(:number) { |n| (3000 + n).to_s }
  end
end
