# frozen_string_literal: true

class OnboardJudgingsController < ApplicationController
  before_action :find_record, only: %i[show update]
  before_action(only: %i[create update]) { require_role :judge }

  def show
    @participant = @record.participant
  end

  def new
    @participant = Participant.find_by number: params.require(:participant)
    @record = OnboardJudging.new participant: @participant
  end

  def create
    OnboardJudging.create! params.require(:onboard_judging).permit!
    redirect_to select_participant_onboard_judgings_path,
                notice: 'Onboard score has been saved.'
  end

  def select_participant
    @participants = Participant.numbered.includes(:onboard_judging)
                               .order(:number).reverse
  end

  def update
    @record.update params.require(:onboard_judging).permit!
    redirect_to select_participant_onboard_judgings_path,
                notice: 'Onboard score has been saved.'
  end

  private

  def find_record
    @record = OnboardJudging.find_by id: params.require(:id)
  end
end
