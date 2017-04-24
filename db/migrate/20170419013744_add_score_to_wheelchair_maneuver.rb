class AddScoreToWheelchairManeuver < ActiveRecord::Migration
  def change
    add_column :wheelchair_maneuvers, :score, :integer
  end
end
