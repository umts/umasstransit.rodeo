class AddSequenceNumberToManeuvers < ActiveRecord::Migration[4.2]
  def change
    add_column :maneuvers, :sequence_number, :integer
  end
end
