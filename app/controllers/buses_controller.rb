class BusesController < ApplicationController
  def create
    Bus.create! bus_params
    redirect_to :back
  end

  def index
    @buses = Bus.order :number
  end

  def destroy
    bus = Bus.find_by id: params.require(:id)  
    bus.destroy!
    redirect_to :back
  end

  private

  def bus_params
    params.require(:bus).permit :number
  end
end
