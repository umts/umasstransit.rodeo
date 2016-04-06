class RecreateBuses < ActiveRecord::Migration
  def change
    create_table :buses do |t|
      t.string :number

      t.timestamps null: false
    end
  end
end
