class ManeuversController < ApplicationController
  before_action :find_maneuver, only: %i(next_participant previous_participant)

  def index
    @maneuvers = Maneuver.order :sequence_number
  end

  def next_participant
    participant = @maneuver.next_participant(params[:relative_to])
    if participant.present?
      if participant.has_completed? @maneuver
        record = ManeuverParticipant.find_by maneuver: @maneuver,
                                             participant: participant
        redirect_to record
      else
        redirect_to(
          new_maneuver_participant_path maneuver: @maneuver.name,
                                        participant: participant.number)
      end
    else redirect_to maneuvers_path
    end
  end

  def previous_participant
    participant = @maneuver.previous_participant(params[:relative_to])
    if participant.present?
      record = ManeuverParticipant.find_by maneuver: @maneuver,
                                           participant: participant
      redirect_to record
    else redirect_to :back and return
    end
  end

  private

  def find_maneuver
    @maneuver = Maneuver.find_by id: params.require(:id)
  end
end
