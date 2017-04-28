class VehiclesController < ApplicationController
  def create
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    vehicle = Vehicle.new vehicle_params
    if vehicle.save
      flash[:notice] = 'Vehicle was successfully added.'
    else flash[:errors] = vehicle.errors.full_messages
    end
    redirect_to :back
  end

  def index
    @vehicles = Vehicle.order :number
  end

  def destroy
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    vehicle = Vehicle.find_by id: params.require(:id)
    vehicle.destroy!
    flash[:notice] = 'Vehicle was successfully deleted.'
    redirect_to :back
  end

  private

  def vehicle_params
    params.require(:vehicle).permit :number
  end
end
