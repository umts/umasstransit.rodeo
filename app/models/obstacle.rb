class Obstacle < ActiveRecord::Base
  belongs_to :maneuver

  validates :x, :y, :point_value, :maneuver, presence: true
end
