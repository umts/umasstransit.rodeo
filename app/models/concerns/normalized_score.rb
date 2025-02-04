# frozen_string_literal: true

module NormalizedScore
  extend ActiveSupport::Concern

  BY = 50

  class_methods do
    def score_calculation
      raw_score = arel_table[score_components[0]]
      possible_score = arel_table[score_components[1]]
      scale = Arel::Nodes::Division.new(BY, possible_score)
      null_as_zero Arel::Nodes::Multiplication.new(scale, raw_score)
    end

    def with_scores
      select score_calculation.as(name.underscore)
    end
  end

  def score
    raw_score = send(self.class.score_components[0])
    possible_score = send(self.class.score_components[1])

    attributes[self.class.name.underscore] || ((BY / possible_score.to_f) * raw_score).round(1)
  end
end
