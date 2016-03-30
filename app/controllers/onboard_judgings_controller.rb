class OnboardJudgingsController < ApplicationController
  before_action :find_record, only: %i(show update)

  def create
    record = OnboardJudging.create! params.require(:onboard_judging).permit!
    redirect_to select_participant_onboard_judgings_path
    PrivatePub.publish_to '/scoreboard', record
  end

  def new
    @participant = Participant.find_by number: params.require(:participant)
    @record = OnboardJudging.new participant: @participant
  end

  def select_participant
    @participants = Participant.includes(:onboard_judging).order :number
  end

  def show
    @participant = @record.participant
  end

  def update
    @record.update params.require(:onboard_judging).permit!
    redirect_to select_participant_onboard_judgings_path
    PrivatePub.publish_to '/scoreboard', @record
  end

  private

  def find_record
    @record = OnboardJudging.find_by id: params.require(:id)
  end
end
