class CreateQuizScores < ActiveRecord::Migration[4.2]
  def change
    create_table :quiz_scores do |t|
      t.float :points_achieved
      t.float :total_points
      t.integer :participant_id

      t.timestamps null: false
    end
  end
end
