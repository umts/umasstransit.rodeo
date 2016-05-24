class QuizScoresController < ApplicationController
  before_action :find_score, only: :update

  def create
    deny_access && return unless current_user.has_role? :quiz_scorer
    score = QuizScore.new score_params
    if score.save
      redirect_to quiz_scores_path, notice: 'Quiz score was saved.'
      PrivatePub.publish_to '/scoreboard', score
    else
      flash[:error] = 'Invalid Score'
      redirect_to :back
    end
  end

  def index
    @participants = Participant.includes(:quiz_score).order :number
    sorted = Participant.unscoped.includes(:quiz_score)
                        .order(:name).group_by do |participant|
      participant.quiz_score.present?
    end
    @scored = sorted[true]
    @unscored = sorted[false]
  end

  def update
    deny_access && return unless current_user.has_role? :quiz_scorer
    if @score.update score_params
      redirect_to quiz_scores_path, notice: 'Quiz score was saved.'
      PrivatePub.publish_to '/scoreboard', @score
    else
      flash[:error] = 'Invalid Score'
      redirect_to :back
    end
  end

  private

  def score_params
    params.require(:quiz_score).permit :participant_id,
                                       :points_achieved,
                                       :total_points
  end

  def find_score
    @score = QuizScore.find_by id: params.require(:id)
  end
end
