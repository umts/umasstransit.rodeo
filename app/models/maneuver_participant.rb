class ManeuverParticipant < ActiveRecord::Base
  belongs_to :maneuver
  belongs_to :participant

  serialize :obstacles_hit, Array

  validates :maneuver, :participant, :score, presence: true
  validates :completed_as_designed, :reversed_direction,
    inclusion: { in: [true, false] }
end
