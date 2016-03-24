class ManeuversController < ApplicationController
  before_action :find_maneuver, only: :next_participant

  def index
    @maneuvers = Maneuver.order :sequence_number
  end

  def next_participant
    redirect_to(
      new_maneuver_participant_path maneuver: @maneuver.name,
                                    participant: @maneuver.next_participant.number
    ) and return
  end

  private

  def find_maneuver
    @maneuver = Maneuver.find_by id: params.require(:id)
  end
end
