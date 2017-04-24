class AddParticipantIdToWheelchairManeuver < ActiveRecord::Migration
  def change
    add_column :wheelchair_maneuvers, :participant_id, :integer
  end
end
