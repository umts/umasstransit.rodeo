class AddSuddenStartsToOnboardJudgings < ActiveRecord::Migration
  def change
    add_column :onboard_judgings, :sudden_starts, :integer
  end
end
