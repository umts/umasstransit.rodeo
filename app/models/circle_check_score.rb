# frozen_string_literal: true

class CircleCheckScore < ApplicationRecord
  belongs_to :participant

  validates :participant, :total_defects, :defects_found, presence: true
  validates :participant, uniqueness: true
  validates :defects_found, numericality: {
    less_than_or_equal_to: :total_defects,
    greater_than_or_equal_to: 0
  }

  TOTAL_DEFECTS_DEFAULT = 5

  def score
    (50 / total_defects) * defects_found
  end
end
