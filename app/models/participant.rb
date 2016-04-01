class Participant < ActiveRecord::Base
  SORT_ORDERS = %i(total_score maneuver_score participant_name participant_number)

  has_many :maneuver_participants, dependent: :destroy
  has_many :maneuvers, through: :maneuver_participants
  has_one :circle_check_score, dependent: :destroy
  has_one :quiz_score, dependent: :destroy
  has_one :onboard_judging, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  default_scope { order :number }

  scope :numbered, -> { where.not number: nil }
  scope :not_numbered, -> { where number: nil }

  def has_completed?(maneuver)
    maneuvers.include? maneuver
  end

  def maneuver_record(maneuver)
    maneuver_participants.find_by maneuver: maneuver
  end

  def maneuver_score
    maneuver_participants.sum :score
  end

  def name_and_number
    if number
      "#{name} (#{number})"
    else name
    end
  end

  def total_score
    total = maneuver_score
    total += onboard_judging.score if onboard_judging.present?
    total += circle_check_score.score if circle_check_score.present?
    total += quiz_score.score if quiz_score.present?
    total
  end

  def self.next_number
    last_number = numbered.pluck(:number).sort.last || 0
    last_number + 1
  end

  def self.scoreboard_order(sort_order = nil)
    if sort_order
      raise ArgumentError unless SORT_ORDERS.include? sort_order
    end
    case sort_order
    when :total_score, nil
      numbered.includes(:maneuver_participants).sort_by(&:total_score).reverse
    when :maneuver_score
      numbered.includes(:maneuver_participants).sort_by(&:maneuver_score).reverse
    when :participant_name
      unscoped.numbered.order :name
    when :participant_number
      numbered.order :number
    end
  end
end
