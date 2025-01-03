# frozen_string_literal: true

module NonManeuverScoreController
  extend ActiveSupport::Concern

  included do
    before_action(only: %i[create update]) { require_role scorer_role }
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
    @page_title = score_name.pluralize.titleize
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
    redirect_to({ action: 'index' }, notice: t('non_maneuver_scores.success', score_name:))
  end

  def score_name
    score_type.model_name.human
  end

  def score_sym
    score_type.model_name.element.to_sym
  end
end
