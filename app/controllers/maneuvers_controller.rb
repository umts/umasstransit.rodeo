# frozen_string_literal: true

class ManeuversController < ApplicationController
  before_action :find_maneuver, only: %i[next_participant previous_participant]

  def index
    @page_title = 'Select a Maneuver'
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
                                        participant: participant.number
        )
      end
    else redirect_to maneuvers_path,
                     notice: 'There are no more participants in the queue for
                              this maneuver.'
    end
  end

  def previous_participant
    participant = @maneuver.previous_participant(params[:relative_to])
    if participant.blank?
      participant = Participant.find_by(number: params[:relative_to])
      flash[:notice] =
        'This is the first participant who completed this maneuver.'
    end
    redirect_to ManeuverParticipant.find_by maneuver: @maneuver,
                                            participant: participant
  end

  private

  def find_maneuver
    @maneuver = Maneuver.find_by id: params.require(:id)
  end
end
