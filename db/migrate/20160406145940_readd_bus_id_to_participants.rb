class ReaddBusIdToParticipants < ActiveRecord::Migration[4.2]
  def change
    add_column :participants, :bus_id, :integer
  end
end
