# frozen_string_literal: true

class DistanceTarget < ApplicationRecord
  belongs_to :maneuver

  validates :x, :y, :direction, :intervals, :multiplier, :maneuver, :name, :minimum, presence: true

  def interval_type
    intervals.zero? ? 'inches' : 'marks'
  end
end
