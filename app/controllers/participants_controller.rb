class ParticipantsController < ApplicationController
  def index
    @participants = Participant.scoreboard_order
    @maneuvers = Maneuver.order :sequence_number
  end

  def scoreboard
    params.require :sort_order
    sort_order = params.fetch(:sort_order).to_sym
    @participants = Participant.scoreboard_order sort_order
    @maneuvers = Maneuver.order :sequence_number
    render partial: 'scoreboard'
  end
end
