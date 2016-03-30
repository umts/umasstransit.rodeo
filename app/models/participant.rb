class Participant < ActiveRecord::Base
  SORT_ORDERS = %i(total_score maneuver_score participant_name participant_number)

  has_many :maneuver_participants
  has_many :maneuvers, through: :maneuver_participants
  has_one :circle_check_score
  has_one :quiz_score
  has_one :onboard_judging

  validates :name, :number, presence: true, uniqueness: true

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
    total += onboard_judging.score if onboard_judging.present?
    total += circle_check_score.score if circle_check_score.present?
    total += quiz_score.score if quiz_score.present?
    total
  end

  def self.next_number
    last_number = pluck(:number).sort.last || 0
    last_number + 1
  end

  def self.scoreboard_order(sort_order = nil)
    if sort_order
      raise ArgumentError unless SORT_ORDERS.include? sort_order
    end
    case sort_order
    when :total_score, nil
      includes(:maneuver_participants).sort_by(&:total_score).reverse
    when :maneuver_score
      includes(:maneuver_participants).sort_by(&:maneuver_score).reverse
    when :participant_name
      unscoped.order :name
    when :participant_number
      order :number
    end
  end
end
