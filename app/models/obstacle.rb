# frozen_string_literal: true

class Obstacle < ApplicationRecord
  belongs_to :maneuver

  validates :x, :y, :point_value, :obstacle_type, :maneuver, presence: true
end
