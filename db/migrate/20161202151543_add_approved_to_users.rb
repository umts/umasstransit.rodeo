class AddApprovedToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :approved, :boolean, default: false
  end
end
