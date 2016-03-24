class AddTypeToObstacles < ActiveRecord::Migration
  def change
    add_column :obstacles, :obstacle_type, :string
  end
end
