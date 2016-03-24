class BusesController < ApplicationController
  def participants
    bus = Bus.find_by number: params.require(:number)
    render json: bus.participants, only: %i(name number)
  end
end
