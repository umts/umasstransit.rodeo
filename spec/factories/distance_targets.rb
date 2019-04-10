FactoryBot.define do
  factory :distance_target do
    name { 'Pivot cone' }
    x { 0 }
    y { 0 }
    direction { 0 }
    intervals { 5 }
    multiplier { 5 }
    minimum { 0 }
    maneuver
  end
end
