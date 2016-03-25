class ParticipantsController < ApplicationController
  def index
    @participants = Participant.scoreboard_order
    @maneuvers = Maneuver.order :sequence_number
  end
end
