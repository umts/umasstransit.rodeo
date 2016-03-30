class RemoveBuses < ActiveRecord::Migration
  def change
    drop_table :buses
  end
end
