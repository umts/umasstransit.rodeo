class Participant < ActiveRecord::Base
  belongs_to :bus
  has_many :maneuver_participants

  validates :name, :number, presence: true, uniqueness: true
  validates :bus, presence: true

  default_scope { order :number }

  def has_completed?(maneuver)
    maneuver_record(maneuver).present?
  end

  def maneuver_record(maneuver)
    ManeuverParticipant.find_by(maneuver: maneuver, participant: self)
  end

  def total_score
    maneuver_participants.sum :score
  end

  def self.next_number
    last_number = pluck(:number).sort.last || 0
    last_number + 1
  end

  def self.scoreboard_order
    joins(:maneuver_participants).uniq.sort_by(&:total_score).reverse
  end
end
