class CreateBuses < ActiveRecord::Migration[4.2]
  def change
    create_table :buses do |t|
      t.string :number

      t.timestamps null: false
    end
  end
end
