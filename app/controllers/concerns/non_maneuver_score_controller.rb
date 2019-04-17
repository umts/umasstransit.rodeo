# frozen_string_literal: true

module NonManeuverScoreController
  extend ActiveSupport::Concern

  included do
    before_action :require_scorer_role, only: %i[create update]
    before_action :find_score, only: :update
  end

  def create
    score = score_type.new score_params
    if score.save
      change_succeeded
    else
      change_failed score.errors.full_messages
    end
  end

  def index
    @participants = Participant.includes(score_sym).order :number
    sorted = Participant.unscoped.includes(score_sym).order(:name)
    sorted = sorted.group_by do |participant|
      participant.send(score_sym).present?
    end
    @scored = sorted[true]
    @unscored = sorted[false]
  end

  def update
    if @score.update score_params
      change_succeeded
    else
      change_failed @score.errors.full_messages
    end
  end

  private

  def find_score
    @score = score_type.find_by id: params.require(:id)
  end

  def change_failed(errors)
    flash[:errors] = errors
    redirect_back fallback_location: { action: 'index' }
  end

  def change_succeeded
    redirect_to({ action: 'index' }, notice: "#{score_name} was saved.")
    update_scoreboard with: @score
  end

  def score_name
    score_type.model_name.human
  end

  def score_sym
    score_type.model_name.element.to_sym
  end

  def require_scorer_role
    deny_access && return unless current_user.has_role? scorer_role
  end
end
