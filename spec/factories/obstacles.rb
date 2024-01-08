# frozen_string_literal: true

FactoryBot.define do
  factory :obstacle do
    x { 0 }
    add_attribute(:y) { 0 } # Kernel#y is a method added by Psych
    point_value { 10 }
    obstacle_type { 'cone' }
    maneuver
  end
end
