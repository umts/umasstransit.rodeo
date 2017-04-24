class RemoveMissedHornSoundsFromOnboardJudgings < ActiveRecord::Migration
  def change
    remove_column :onboard_judgings, :missed_horn_sounds
  end
end
