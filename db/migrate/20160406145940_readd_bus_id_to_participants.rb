class ReaddBusIdToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :bus_id, :integer
  end
end
