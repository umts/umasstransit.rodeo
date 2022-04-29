class RemoveBuses < ActiveRecord::Migration[4.2]
  def change
    drop_table :buses
  end
end
