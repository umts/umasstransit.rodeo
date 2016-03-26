class Participant < ActiveRecord::Base
  belongs_to :bus
  has_many :maneuver_participants
  has_many :maneuvers, through: :maneuver_participants
  has_one :circle_check_score
  has_one :quiz_score

  validates :name, :number, presence: true, uniqueness: true
  validates :bus, presence: true

  default_scope { order :number }

  def has_completed?(maneuver)
    maneuvers.include? maneuver
  end

  def maneuver_record(maneuver)
    maneuver_participants.find_by maneuver: maneuver
  end

  def maneuver_score
    maneuver_participants.sum :score
  end

  def total_score
    total = maneuver_score
    total += circle_check_score.score if circle_check_score.present?
    total += quiz_score.score if quiz_score.present?
    total
  end

  def self.next_number
    last_number = pluck(:number).sort.last || 0
    last_number + 1
  end

  def self.scoreboard_order
    joins(:maneuver_participants).uniq.sort_by(&:total_score).reverse
  end
end
