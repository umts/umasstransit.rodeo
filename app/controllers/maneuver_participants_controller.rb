class ManeuverParticipantsController < ApplicationController
  def new
    @maneuver = Maneuver.find_by name: params.require(:maneuver)
    @participant = Participant.find_by number: params.require(:participant)
    @record = ManeuverParticipant.new maneuver: @maneuver,
                                      participant: @participant
  end

  def create
    maneuver = Maneuver.find_by id: params.require(:maneuver_id)
    participant = Participant.find_by id: params.require(:participant_id)
    unless participant.has_completed? maneuver
    end
    redirect_to next_participant_maneuver_path(maneuver)
  end
end
