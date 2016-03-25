class CreateCircleCheckScores < ActiveRecord::Migration
  def change
    create_table :circle_check_scores do |t|
      t.integer :total_defects
      t.integer :defects_found
      t.integer :participant_id

      t.timestamps null: false
    end
  end
end
