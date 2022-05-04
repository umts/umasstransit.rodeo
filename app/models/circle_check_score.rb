# frozen_string_literal: true

class CircleCheckScore < ApplicationRecord
  include ScoreboardPublisher

  belongs_to :participant

  validates :participant, :total_defects, :defects_found, presence: true
  validates :participant, uniqueness: true
  validates :defects_found, numericality: {
    less_than_or_equal_to: :total_defects,
    greater_than_or_equal_to: 0
  }

  TOTAL_DEFECTS_DEFAULT = 5

  def self.score_calculation
    total_defects = arel_table[:total_defects]
    defects_found = arel_table[:defects_found]
    scale = Arel::Nodes::Division.new(50, total_defects)
    null_as_zero Arel::Nodes::Multiplication.new(scale, defects_found)
  end

  def self.with_scores
    select score_calculation.as('circle_check_score')
  end

  def as_json(options = {})
    super(options).merge(score: score)
  end

  def score
    attributes['circle_check_score'] || (50 / total_defects.to_f) * defects_found
  end
end
