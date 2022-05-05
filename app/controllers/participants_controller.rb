# frozen_string_literal: true

class ParticipantsController < ApplicationController
  before_action :find_user, only: %i[assign_number destroy update]
  skip_before_action :authenticate_user!, only: %i[scoreboard welcome]
  before_action except: %i[index scoreboard welcome] do
    require_role :master_of_ceremonies
  end

  def assign_number
    @participant.update! number: params.require(:number),
                         bus_id: params.require(:bus_id)
    redirect_to participants_path,
                notice: 'Participant has been added to the queue.'
  end

  def create
    participant = Participant.new user_params
    if participant.save
      flash[:notice] = 'Participant was successfully created.'
    else
      flash[:errors] = participant.errors.full_messages
    end
    redirect_to participants_path
  end

  def destroy
    @participant.destroy!
    redirect_to participants_path,
                notice: 'Participant has been removed.'
  end

  def index
    @participants = Participant.order(:created_at).reverse
    @unassigned = Participant.not_numbered.order :name
    @next_number = Participant.next_number
    @buses = Bus.order :number
  end

  def scoreboard
    params.permit :sort_order
    @page_title = 'Scoreboard'
    @can_edit_scores = current_user.try :admin?
    @sort_order = params[:sort_order].try :to_sym

    @maneuvers = Maneuver.order :sequence_number
    if (@participants_exist = Participant.numbered.any?)
      @maneuver_participants = ManeuverParticipant.scoreboard_grouping
      @participants = Participant.scoreboard_data.scoreboard_order @sort_order
    end
  end

  def update
    return unless @participant.update user_params

    redirect_to participants_path, notice: 'Participant has been updated.'
  end

  def welcome
    @page_title = 'Welcome'
  end

  private

  def find_user
    @participant = Participant.find_by id: params.require(:id)
  end

  def user_params
    params.require(:participant).permit :name, :number, :bus_id
  end
end
