class Maneuver < ActiveRecord::Base
  serialize :obstacles, Array
  serialize :distance_targets, Array

  validates :name, :obstacles, presence: true
  validates :completed_as_designed, :reversed_direction,
    inclusion: { in: [true, false] }
end
