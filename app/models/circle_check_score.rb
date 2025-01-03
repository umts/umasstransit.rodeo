# frozen_string_literal: true

class CircleCheckScore < ApplicationRecord
  include NormalizedScore
  include ScoreboardPublisher

  has_paper_trail

  belongs_to :participant

  validates :total_defects, :defects_found, presence: true
  validates :participant, uniqueness: true
  validates :defects_found, numericality: {
    less_than_or_equal_to: :total_defects,
    greater_than_or_equal_to: 0
  }

  TOTAL_DEFECTS_DEFAULT = 5

  def self.score_components = %i[defects_found total_defects]

  def as_json(options = {})
    super.merge(score:)
  end
end
