class ChangeTimeElapsedToMinutesAndSeconds < ActiveRecord::Migration
  def change
    add_column :onboard_judgings, :minutes_elapsed, :integer
  end
end
