class RemoveMissedFlashersFromOnboardJudgings < ActiveRecord::Migration
  def change
    remove_column :onboard_judgings, :missed_flashers
  end
end
