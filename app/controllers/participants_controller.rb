class ParticipantsController < ApplicationController
  before_action :find_user, only: %i(destroy update)

  def create
    participant = Participant.create! user_params
    redirect_to participants_path
    PrivatePub.publish_to '/scoreboard', participant
  end

  def destroy
    @participant.destroy!
    redirect_to participants_path
    PrivatePub.publish_to '/scoreboard', removed: @participant
  end

  def index
    @participants = Participant.order :number
  end

  def scoreboard
    @participants = Participant.scoreboard_order
    @maneuvers = Maneuver.order :sequence_number
  end

  def scoreboard_partial
    params.require :sort_order
    sort_order = params.fetch(:sort_order).to_sym
    @participants = Participant.scoreboard_order sort_order
    @maneuvers = Maneuver.order :sequence_number
    render partial: 'scoreboard_partial'
  end

  def update
    @participant.update! user_params
    redirect_to participants_path
    PrivatePub.publish_to '/scoreboard', @participant
  end

  private

  def find_user
    @participant = Participant.find_by id: params.require(:id)
  end

  def user_params
    params.require(:participant).permit :name, :number
  end
end
