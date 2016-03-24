class ManeuversController < ApplicationController
  before_action :find_maneuver, only: %i(show)

  def index
    @maneuvers = Maneuver.order :sequence_number
  end

  def show
    @buses = Bus.order :number
  end

  private

  def find_maneuver
    @maneuver = Maneuver.find_by id: params.require(:id)
  end
end
