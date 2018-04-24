class RemoveUnannouncedStopsFromOnboardJudgings < ActiveRecord::Migration
  def change
    remove_column :onboard_judgings, :unannounced_stops
  end
end
