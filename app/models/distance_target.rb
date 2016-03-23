class DistanceTarget < ActiveRecord::Base
  belongs_to :maneuver

  validates :x, :y, :direction, :intervals, :multiplier, :maneuver,
    presence: true
end
