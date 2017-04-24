class OnboardJudging < ActiveRecord::Base
  has_paper_trail

  belongs_to :participant
  validates :participant, uniqueness: true
  validates :score, :minutes_elapsed, :seconds_elapsed, presence: true
  validates :minutes_elapsed, numericality: {
    greater_than_or_equal_to: 0 }
  validates :seconds_elapsed, inclusion: { in: 0..59 }

  SCORE_COLUMNS = %w(
    missed_turn_signals abrupt_turns
    sudden_stops sudden_starts
  ).freeze

  before_validation :initialize_score_attributes
  before_validation :set_score

  def creator
    user_id = versions.find_by(event: 'create').whodunnit
    User.find_by id: user_id if user_id
  end

  private

  def initialize_score_attributes
    SCORE_COLUMNS.select do |column_name|
      attributes[column_name].nil?
    end.each do |column_name|
      write_attribute column_name, 0
    end
  end

  # rubocop:disable Metrics/AbcSize
  def set_score
    score = 50
    score -= 20 * sudden_stops
    score -= 20 * sudden_starts
    score -= 20 * abrupt_turns
    score -= 20 * missed_turn_signals
    total_seconds_elapsed = (minutes_elapsed * 60) + seconds_elapsed
    if total_seconds_elapsed > 630
      score -= total_seconds_elapsed - 630 * 1
    end
    assign_attributes score: score
  end
  # rubocop:enable Metrics/AbcSize
end
