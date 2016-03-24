class ManeuverParticipantsController < ApplicationController
  def new
    @maneuver = Maneuver.find_by name: params.require(:maneuver)
    @participant = Participant.find_by number: params.require(:participant)
    @record = ManeuverParticipant.new maneuver: @maneuver,
                                      participant: @participant
  end
end
