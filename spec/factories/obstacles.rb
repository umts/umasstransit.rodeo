FactoryBot.define do
  factory :obstacle do
    x { 0 }
    y { 0 }
    point_value { 10 }
    obstacle_type { 'cone' }
    maneuver
  end
end
