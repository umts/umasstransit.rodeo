class Obstacle < ActiveRecord::Base
  belongs_to :maneuver

  validates :x, :y, :point_value, :obstacle_type, :maneuver, presence: true
end
