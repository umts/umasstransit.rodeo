class AddSequenceNumberToManeuvers < ActiveRecord::Migration
  def change
    add_column :maneuvers, :sequence_number, :integer
  end
end
