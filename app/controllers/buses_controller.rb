class BusesController < ApplicationController
  def create
    Bus.create bus_params
    redirect_to :back
  end

  private

  def bus_params
    params.require(:bus).permit :number
  end
end
