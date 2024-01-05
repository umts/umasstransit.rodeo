class AddSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :settings do |t|
      t.integer :singleton_guard, null: false
      t.index :singleton_guard, unique: true
      t.boolean :scores_locked, default: true, null: false
    end
  end
end
