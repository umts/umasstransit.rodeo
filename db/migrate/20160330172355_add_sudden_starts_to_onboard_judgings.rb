class AddSuddenStartsToOnboardJudgings < ActiveRecord::Migration[4.2]
  def change
    add_column :onboard_judgings, :sudden_starts, :integer
  end
end
