class CircleCheckScoresController < ApplicationController
  include NonManeuverScoreController

  private

  def score_params
    params.require(:circle_check_score)
          .permit(:participant_id, :defects_found, :total_defects)
  end

  def scorer_role
    :circle_check_scorer
  end

  def score_type
    CircleCheckScore
  end
end
