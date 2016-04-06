class ParticipantsController < ApplicationController
  before_action :find_user, only: %i(assign_number destroy update)
  skip_before_action :authenticate_user!, only: %i(scoreboard scoreboard_partial welcome)

  def assign_number
    params.require :number
    @participant.update number: params[:number]
    redirect_to participants_path,
      notice: 'Participant has been added to the queue.'
    PrivatePub.publish_to '/scoreboard', @participant
  end

  def create
    participant = Participant.create! user_params
    redirect_to participants_path,
      notice: 'Participant has been created.'
    PrivatePub.publish_to '/scoreboard', participant
  end

  def destroy
    @participant.destroy!
    redirect_to participants_path,
      notice: 'Participant has been removed.'
    PrivatePub.publish_to '/scoreboard', removed: @participant
  end

  def index
    @participants = Participant.order(:created_at).reverse
    @unassigned = Participant.not_numbered.order :name
    @next_number = Participant.next_number
  end

  def scoreboard
    @can_edit_scores = current_user.try :admin?
    @participants = Participant.scoreboard_order
    @top_20 = @participants.first 20
    @maneuvers = Maneuver.order :sequence_number
    @scores = ManeuverParticipant.scoreboard_grouping
  end

  def scoreboard_partial
    params.require :sort_order
    sort_order = params.fetch(:sort_order).to_sym
    @can_edit_scores = current_user.try :admin?
    @participants = Participant.scoreboard_order sort_order
    @top_20 = Participant.top_20
    @maneuvers = Maneuver.order :sequence_number
    @scores = ManeuverParticipant.scoreboard_grouping
    render partial: 'scoreboard_partial'
  end

  def update
    @participant.update! user_params
    redirect_to participants_path,
      notice: 'Participant has been updated.'
    PrivatePub.publish_to '/scoreboard', @participant
  end

  def welcome
  end

  private

  def find_user
    @participant = Participant.find_by id: params.require(:id)
  end

  def user_params
    params.require(:participant).permit :name, :number
  end
end
