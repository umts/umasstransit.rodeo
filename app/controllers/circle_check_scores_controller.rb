class CircleCheckScoresController < ApplicationController
  before_action :find_score, only: :update

  def create
    deny_access && return unless current_user.has_role? :circle_check_scorer
    score = CircleCheckScore.new score_params
    if score.save
      redirect_to circle_check_scores_path, notice: 'Score was saved.'
      update_scoreboard with: score
    else
      flash[:errors] = score.errors.full_messages
      redirect_back fallback_location: circle_check_scores_path
    end
  end

  def index
    sorted = Participant.unscoped.includes(:circle_check_score).order(:name)
    sorted = sorted.group_by do |participant|
      participant.circle_check_score.present?
    end
    @scored = sorted[true]
    @unscored = sorted[false]
  end

  def update
    deny_access && return unless current_user.has_role? :circle_check_scorer
    if @score.update score_params
      redirect_to circle_check_scores_path, notice: 'Score was saved.'
      update_scoreboard with: @score
    else
      flash[:errors] = @score.errors.full_messages
      redirect_back fallback_location: circle_check_scores_path
    end
  end

  private

  def score_params
    params.require(:circle_check_score)
          .permit(:participant_id, :defects_found, :total_defects)
  end

  def find_score
    @score = CircleCheckScore.find_by id: params.require(:id)
  end
end
