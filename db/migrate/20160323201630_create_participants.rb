class CreateParticipants < ActiveRecord::Migration[4.2]
  def change
    create_table :participants do |t|
      t.string :name
      t.integer :number

      t.timestamps null: false
    end
  end
end
