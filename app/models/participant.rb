class Participant < ActiveRecord::Base
  has_paper_trail

  SORT_ORDERS = %i(total_score
                   maneuver_score
                   participant_name
                   participant_number).freeze

  belongs_to :bus
  has_many :maneuver_participants, dependent: :destroy
  has_many :maneuvers, through: :maneuver_participants
  has_one :circle_check_score, dependent: :destroy
  has_one :quiz_score, dependent: :destroy
  has_one :onboard_judging, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :bus, presence: true, if: -> { number.present? }

  default_scope { order :number }

  scope :numbered, -> { where.not number: nil }
  scope :not_numbered, -> { where number: nil }

  def has_completed?(maneuver)
    maneuvers.include? maneuver
  end

  def maneuver_score
    maneuver_participants.sum :score
  end

  def display_information(*options)
    # option can be any symbol with a corresponding method on Participant.
    result = options.map do |option|
      case option
      when :bus
        bus.try :number
      when :number
        number.try(:to_s).try :prepend, '#'
      else
        send(option)
      end
    end
    first = result.shift
    last = result.compact.join(', ')
    if last.present?
      "#{first} (#{last})"
    else
      first.to_s
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

  # rubocop:disable Metrics/CyclomaticComplexity
  def self.scoreboard_order(sort_order = nil)
    if sort_order
      raise ArgumentError unless SORT_ORDERS.include? sort_order
    end
    case sort_order
    when :total_score, nil
      numbered.includes(:maneuver_participants).sort_by(&:total_score).reverse
    when :maneuver_score
      numbered.includes(:maneuver_participants)
              .sort_by(&:maneuver_score).reverse
    when :participant_name
      unscoped.numbered.order :name
    when :participant_number
      numbered.order :number
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def self.top_20
    numbered.includes(:maneuver_participants)
            .sort_by(&:total_score).reverse.first 20
  end
end
