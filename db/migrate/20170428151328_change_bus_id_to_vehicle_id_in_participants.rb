class ChangeBusIdToVehicleIdInParticipants < ActiveRecord::Migration
  def change
    rename_column :participants, :bus_id, :vehicle_id
  end
end
