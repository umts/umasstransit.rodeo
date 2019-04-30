# frozen_string_literal: true

class BusesController < ApplicationController
  def create
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    bus = Bus.new bus_params
    if bus.save
      flash[:notice] = 'Bus was successfully added.'
    else flash[:errors] = bus.errors.full_messages
    end
    redirect_back fallback_location: buses_path
  end

  def index
    @page_title = 'Buses'
    @buses = Bus.order :number
  end

  def destroy
    deny_access && return unless current_user.has_role? :master_of_ceremonies
    bus = Bus.find_by id: params.require(:id)
    bus.destroy!
    flash[:notice] = 'Bus was successfully deleted.'
    redirect_back fallback_location: buses_path
  end

  private

  def bus_params
    params.require(:bus).permit :number
  end
end
