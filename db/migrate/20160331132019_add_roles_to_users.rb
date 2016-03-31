class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :judge, :boolean, null: false, default: false
    add_column :users, :quiz_scorer, :boolean, null: false, default: false
    add_column :users, :circle_check_scorer, :boolean, null: false, default: false
    add_column :users, :master_of_ceremonies, :boolean, null: false, default: false
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
