class CircleCheckScoresController < ApplicationController
  before_action :find_score, only: :update

  def create
    score = CircleCheckScore.create! score_params
    redirect_to circle_check_scores_path
    PrivatePub.publish_to '/scoreboard', score
  end

  def index
    @participants = Participant.includes(:circle_check_score).order :number
  end

  def update
    @score.update! score_params
    redirect_to circle_check_scores_path
    PrivatePub.publish_to '/scoreboard', @score
  end

  private

  def score_params
    params.require(:circle_check_score).permit(:participant_id, :defects_found, :total_defects)
  end

  def find_score
    @score = CircleCheckScore.find_by id: params.require(:id)
  end
end
