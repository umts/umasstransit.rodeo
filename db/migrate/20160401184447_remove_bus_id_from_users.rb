class RemoveBusIdFromUsers < ActiveRecord::Migration[4.2]
  def change
    remove_column :participants, :bus_id, :integer
  end
end
