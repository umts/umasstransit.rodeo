class RemoveTimesMovedWithDoorOpenFromOnboardJudgings < ActiveRecord::Migration
  def change
    remove_column :onboard_judgings, :times_moved_with_door_open
  end
end
