class BusesController < ApplicationController
  def create
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    bus = Bus.new bus_params
    if bus.save
      flash[:notice] = 'Bus was successfully added.'
    else flash[:errors] = bus.errors.full_messages
    end
    redirect_to :back
  end

  def index
    @buses = Bus.order :number
  end

  def destroy
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    bus = Bus.find_by id: params.require(:id)
    bus.destroy!
    redirect_to :back
  end

  private

  def bus_params
    params.require(:bus).permit :number
  end
end
