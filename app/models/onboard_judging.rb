# frozen_string_literal: true

class OnboardJudging < ApplicationRecord
  include ScoreboardPublisher

  has_paper_trail

  belongs_to :participant
  validates :participant, uniqueness: true
  validates :score, :minutes_elapsed, :seconds_elapsed, presence: true
  validates :minutes_elapsed, numericality: {
    greater_than_or_equal_to: 0
  }
  validates :seconds_elapsed, inclusion: { in: 0..59 }

  before_validation :initialize_score_attributes
  before_validation :set_score

  SCORE_COLUMNS = %w[
    missed_turn_signals missed_horn_sounds missed_flashers abrupt_turns
    times_moved_with_door_open unannounced_stops sudden_stops sudden_starts
  ].freeze

  def creator
    user_id = versions.find_by(event: 'create').whodunnit
    User.find_by id: user_id if user_id
  end

  private

  def initialize_score_attributes
    SCORE_COLUMNS.each do |column_name|
      self[column_name] ||= 0
    end
  end

  # rubocop:disable Metrics/AbcSize
  def set_score
    score = 50
    score -= missed_turn_signals
    score -= 3 * missed_horn_sounds
    score -= 3 * missed_flashers
    score -= 3 * times_moved_with_door_open
    score -= 10 * unannounced_stops
    score -= sudden_stops
    score -= sudden_starts
    score -= abrupt_turns
    score -= 60 * (minutes_elapsed - 7) + seconds_elapsed if minutes_elapsed >= 7
    assign_attributes score: score
  end
  # rubocop:enable Metrics/AbcSize
end
