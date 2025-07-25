# frozen_string_literal: true

class OnboardJudging < ApplicationRecord
  include ScoreboardPublisher

  MAX_SCORE = 50

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

  def creator
    user_id = versions.find_by(event: 'create').whodunnit
    User.find_by id: user_id if user_id
  end

  private

  def initialize_score_attributes
    penalties.each_key do |column_name|
      self[column_name] ||= 0
    end
  end

  def penalties
    {
      missed_turn_signals: 1,
      missed_horn_sounds: 3,
      missed_flashers: 3,
      times_moved_with_door_open: 3,
      unannounced_stops: 10,
      sudden_stops: 1,
      sudden_starts: 1,
      abrupt_turns: 1
    }
  end

  def set_score
    score = MAX_SCORE - time_penalty -
            penalties.sum { |type, pen| self[type] * pen }
    assign_attributes score:
  end

  def time_penalty
    [0, ((minutes_elapsed * 60) + seconds_elapsed) - (7 * 60)].max
  end
end
