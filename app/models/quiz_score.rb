# frozen_string_literal: true

class QuizScore < ApplicationRecord
  include ScoreboardPublisher

  has_paper_trail

  belongs_to :participant

  validates :participant, :points_achieved, :total_points, presence: true
  validates :participant, uniqueness: true
  validates :points_achieved, numericality: {
    less_than_or_equal_to: :total_points,
    greater_than_or_equal_to: 0
  }

  TOTAL_POINTS_DEFAULT = 100

  def self.score_calculation
    total_points = arel_table[:total_points]
    points_achieved = arel_table[:points_achieved]
    scale = Arel::Nodes::Division.new(50, total_points)
    null_as_zero Arel::Nodes::Multiplication.new(scale, points_achieved)
  end

  def self.with_scores
    select score_calculation.as('quiz_score')
  end

  def as_json(options = {})
    super(options).merge(score: score)
  end

  def score
    attributes['quiz_score'] || (50 / total_points * points_achieved).round(1)
  end
end
