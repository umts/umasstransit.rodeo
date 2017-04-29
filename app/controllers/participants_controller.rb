class ParticipantsController < ApplicationController
  before_action :find_user, only: %i(assign_number destroy update)
  before_action :scoreboard_data, only: %i(scoreboard scoreboard_partial)
  skip_before_action :authenticate_user!,
                     only: %i(scoreboard scoreboard_partial welcome)

  def assign_number
    @participant.update! number: params.require(:number),
                         vehicle_id: params.require(:vehicle_id)
    redirect_to participants_path,
                notice: 'Participant has been added to the queue.'
    update_scoreboard with: @participant
  end

  def create
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    participant = Participant.new user_params
    if participant.save
      redirect_to participants_path
      flash[:notice] = 'Participant was successfully created.'
      update_scoreboard with: participant
    else
      redirect_to participants_path
      flash[:errors] = participant.errors.full_messages
    end
  end

  def destroy
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    @participant.destroy!
    redirect_to participants_path,
                notice: 'Participant has been removed.'
    update_scoreboard with: @participant
  end

  def index
    @participants = Participant.order(:created_at).reverse
    @unassigned = Participant.not_numbered.order :name
    @next_number = Participant.next_number
    @vehicles = Vehicle.order :number
  end

  def scoreboard_partial
    render partial: 'scoreboard_partial'
  end

  def update
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    if @participant.update user_params
      redirect_to participants_path,
                  notice: 'Participant has been updated.'
      update_scoreboard with: @participant
    end
  end

  private

  def find_user
    @participant = Participant.find_by id: params.require(:id)
  end

  def user_params
    params.require(:participant).permit :name, :number, :vehicle_id
  end

  def scoreboard_data
    params.permit :sort_order
    sort_order = params[:sort_order].try :to_sym
    @participants = Participant.scoreboard_order sort_order
    @can_edit_scores = current_user.try :admin?
    @maneuvers = Maneuver.order :sequence_number
    @scores = ManeuverParticipant.scoreboard_grouping
    @top_20 = Participant.top_20
  end
end
