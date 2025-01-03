# frozen_string_literal: true

class QuizScore < ApplicationRecord
  include NormalizedScore
  include ScoreboardPublisher

  has_paper_trail

  belongs_to :participant

  validates :points_achieved, :total_points, presence: true
  validates :participant, uniqueness: true
  validates :points_achieved, numericality: {
    less_than_or_equal_to: :total_points,
    greater_than_or_equal_to: 0
  }

  TOTAL_POINTS_DEFAULT = 100

  def self.score_components = %i[points_achieved total_points]

  def as_json(options = {})
    super.merge(score:)
  end
end
