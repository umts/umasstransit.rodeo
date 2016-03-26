class QuizScoresController < ApplicationController
  before_action :find_score, only: :update

  def create
    QuizScore.create! score_params
    redirect_to quiz_scores_path
  end

  def index
    @participants = Participant.includes(:quiz_score).order :number
  end

  def update
    @score.update! score_params
    redirect_to quiz_scores_path
  end

  private

  def score_params
    params.require(:quiz_score).permit(:participant_id, :points_achieved, :total_points)
  end

  def find_score
    @score = QuizScore.find_by id: params.require(:id)
  end
end
