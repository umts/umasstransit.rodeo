class ManeuversController < ApplicationController
  before_action :find_maneuver, only: %i(show)

  def index
    @maneuvers = Maneuver.order :sequence_number
  end

  def show
  end

  private

  def find_maneuver
  end
end
