FactoryBot.define do
  factory :vehicle do
    sequence(:number) { |n| "Vehicle #{n}" }
  end
end
