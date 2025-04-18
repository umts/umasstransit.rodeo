# frozen_string_literal: true

class QuizScoresController < ApplicationController
  include NonManeuverScoreController

  private

  def score_params
    params.expect quiz_score: %i[participant_id points_achieved total_points]
  end

  def scorer_role
    :quiz_scorer
  end

  def score_type
    QuizScore
  end
end
