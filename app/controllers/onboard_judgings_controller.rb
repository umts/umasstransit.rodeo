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
    OnboardJudging.create! onboard_judging_params
    redirect_to select_participant_onboard_judgings_path, notice: t('.success')
  end

  def select_participant
    @participants = Participant.numbered.includes(:onboard_judging)
                               .order(:number).reverse
  end

  def update
    @record.update onboard_judging_params
    redirect_to select_participant_onboard_judgings_path, notice: t('.success')
  end

  private

  def find_record
    @record = OnboardJudging.find_by id: params.require(:id)
  end

  def onboard_judging_params
    time_fields = %i[minutes_elapsed seconds_elapsed]
    safety_fields = %i[missed_turn_signals missed_horn_sounds missed_flashers times_moved_with_door_open]
    smoothness_fields = %i[unannounced_stops sudden_stops sudden_starts abrupt_turns]

    params.require(:onboard_judging).permit([:participant_id] + time_fields + safety_fields + smoothness_fields)
  end
end
