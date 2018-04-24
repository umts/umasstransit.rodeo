class AddCountsReversesToManeuvers < ActiveRecord::Migration
  def change
    add_column :maneuvers, :counts_reverses, :boolean, default: false
  end
end
