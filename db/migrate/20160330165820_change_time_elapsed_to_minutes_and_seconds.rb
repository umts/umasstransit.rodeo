class ChangeTimeElapsedToMinutesAndSeconds < ActiveRecord::Migration[4.2]
  def change
    add_column :onboard_judgings, :minutes_elapsed, :integer
  end
end
