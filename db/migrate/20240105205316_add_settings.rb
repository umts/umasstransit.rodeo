class AddSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.integer :singleton_guard
      t.boolean :scores_locked, default: false
    end

    add_index :settings, :singleton_guard, unique: true
  end
end
