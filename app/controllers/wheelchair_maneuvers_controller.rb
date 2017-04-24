class WheelchairManeuversController < ApplicationController
  before_action :find_record, only: %i(show update)

  def create
    deny_access && return unless current_user.has_role? :judge
    record = WheelchairManeuver.create! params.require(:wheelchair_maneuver).permit!
    redirect_to select_participant_wheelchair_maneuvers_path
    update_scoreboard with: record
  end

  def new
    @wheelchair_maneuver = WheelchairManeuver.new
    @participant = Participant.find_by(number: params.require(:participant))
  end

  def select_participant
    @participants = Participant.all
  end

  def show
    @wheelchair_maneuver = WheelchairManeuver.find(params.require(:id))
    @participant = @wheelchair_maneuver.participant
  end

  def update
    deny_access && return unless current_user.has_role? :judge
    number_wrong = params[:checks].values.map(&:to_i).select(&:zero?).count
    @record.update number_wrong: number_wrong
    redirect_to select_participant_wheelchair_maneuvers_path,
                notice: 'Onboard score has been saved.'
    update_scoreboard with: @record
  end

  private

  def find_record
    @record = WheelchairManeuver.find(params.require(:id))
  end

end
