class RemoveBusIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :participants, :bus_id, :integer
  end
end
