class AddLockScoresToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :lock_scores, :boolean, default: false
  end
end
