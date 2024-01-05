# frozen_string_literal: true

FactoryBot.define do
  factory :distance_target do
    name { 'Pivot cone' }
    x { 0 }
    add_attribute(:y) { 0 } # Kernel#y is a method added by Psych
    direction { 0 }
    intervals { 5 }
    multiplier { 5 }
    minimum { 0 }
    maneuver
  end
end
