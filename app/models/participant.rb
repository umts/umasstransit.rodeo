# frozen_string_literal: true

class Participant < ApplicationRecord
  has_paper_trail

  SORT_ORDERS = %i[total_score
                   maneuver_score
                   participant_name
                   participant_number].freeze

  belongs_to :bus, optional: true
  has_many :maneuver_participants, dependent: :destroy
  has_many :maneuvers, through: :maneuver_participants
  has_one :circle_check_score, dependent: :destroy
  has_one :quiz_score, dependent: :destroy
  has_one :onboard_judging, dependent: :destroy
  validates :number, uniqueness: true, if: -> { number.present? }
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :bus, presence: true, if: -> { number.present? }
  validates :number, numericality: { greater_than_or_equal_to: 0 },
                     allow_blank: true

  scope :numbered, -> { where.not number: nil }
  scope :not_numbered, -> { where number: nil }

  after_destroy :update_scoreboard
  after_save :update_scoreboard

  def self.include_circle_check
    select("`#{table_name}`.*")
      .left_joins(:circle_check_score).eager_load(:circle_check_score)
      .merge(CircleCheckScore.with_scores)
  end

  def self.include_onboard
    select("`#{table_name}`.*",
           "#{null_as_zero('`onboard_judgings`.`score`').to_sql} AS oj_score")
      .left_joins(:onboard_judging).eager_load(:onboard_judging)
  end

  def self.include_quiz
    select("`#{table_name}`.*")
      .left_joins(:quiz_score).eager_load(:quiz_score)
      .merge(QuizScore.with_scores)
  end

  def self.include_mp_sum
    joins(<<~JOIN).select("`#{table_name}`.*", 'maneuver_sums.maneuver_sum')
      LEFT OUTER JOIN (#{ManeuverParticipant.participant_sums.to_sql}) maneuver_sums
      ON maneuver_sums.participant_id = `participants`.`id`
    JOIN
  end

  def self.scoreboard_data
    oj_score = null_as_zero('`onboard_judgings`.`score`').to_sql
    man_sum = null_as_zero('maneuver_sums.maneuver_sum').to_sql

    numbered
      .include_quiz
      .include_circle_check
      .include_onboard
      .include_mp_sum
      .left_joins(:maneuver_participants).includes(:maneuver_participants)
      .select "#{man_sum} + #{oj_score} AS maneuver_score",
              "#{man_sum} + #{oj_score} + #{QuizScore.score_calculation.to_sql} + " \
              "#{CircleCheckScore.score_calculation.to_sql} AS total_score",
              is_top(Arel.sql('total_score').desc, arel_table[:id], top: 20).to_sql
  end

  def as_json(options = {})
    display_name = show_name? ? display_information(:name, :number) : display_information(:number)

    super(options).merge display_name: display_name,
                         onboard_score: onboard_judging&.score,
                         maneuver_score: maneuver_score,
                         circle_check_score: circle_check_score&.score,
                         quiz_score: quiz_score&.score,
                         total_score: total_score
  end

  def completed?(maneuver)
    maneuvers.include? maneuver
  end

  def maneuver_score
    attributes['maneuver_score'] ||
      maneuver_participants.sum(:score) + onboard_judging&.score.to_i
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
    attributes['total_score'] ||
      maneuver_score + circle_check_score&.score.to_i + quiz_score&.score.to_i
  end

  def show_name?
    attributes['top_20'] == 1 ||
      attributes['top_20'].blank? && Participant.scoreboard_data.reject { |p| p.top_20.zero? }.include?(self)
  end

  def self.next_number
    maximum(:number).to_i + 1
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def self.scoreboard_order(sort_order = nil)
    raise ArgumentError if sort_order && SORT_ORDERS.exclude?(sort_order)

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
  # rubocop:enable Metrics/CyclomaticComplexity

  private

  def number_changed_from_blank?
    saved_change_to_number? && saved_changes[:number][0].blank?
  end

  def number_changed_to_blank?
    saved_change_to_number? && number.blank?
  end

  def update_scoreboard
    if destroyed? || number_changed_to_blank?
      ScoreboardService.update with: self, type: :remove
    elsif number_changed_from_blank?
      ScoreboardService.update with: self, type: :add
    elsif number?
      ScoreboardService.update with: self
    end
  end
end
