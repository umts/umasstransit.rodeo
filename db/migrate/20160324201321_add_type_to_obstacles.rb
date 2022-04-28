class AddTypeToObstacles < ActiveRecord::Migration[4.2]
  def change
    add_column :obstacles, :obstacle_type, :string
  end
end
