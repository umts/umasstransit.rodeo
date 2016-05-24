class OnboardJudgingsController < ApplicationController
  before_action :find_record, only: %i(show update)

  def create
    deny_access && return unless current_user.has_role? :judge
    record = OnboardJudging.create! params.require(:onboard_judging).permit!
    redirect_to select_participant_onboard_judgings_path,
                notice: 'Onboard score has been saved.'
    PrivatePub.publish_to '/scoreboard', record
  end

  def new
    @participant = Participant.find_by number: params.require(:participant)
    @record = OnboardJudging.new participant: @participant
  end

  def select_participant
    @participants = Participant.numbered.includes(:onboard_judging)
                               .order(:number).reverse
  end

  def show
    @participant = @record.participant
  end

  def update
    deny_access && return unless current_user.has_role? :judge
    @record.update params.require(:onboard_judging).permit!
    redirect_to select_participant_onboard_judgings_path,
                notice: 'Onboard score has been saved.'
    PrivatePub.publish_to '/scoreboard', @record
  end

  private

  def find_record
    @record = OnboardJudging.find_by id: params.require(:id)
  end
end
