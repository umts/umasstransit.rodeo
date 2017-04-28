class ChangeBusToVehicle < ActiveRecord::Migration
  def change
    rename_table :buses, :vehicles
  end
end
