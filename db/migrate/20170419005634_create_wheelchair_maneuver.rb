class CreateWheelchairManeuver < ActiveRecord::Migration
  def change
    create_table :wheelchair_maneuvers do |t|
      t.boolean :first_ask_to_touch
      t.boolean :first_check_brakes_on
      t.boolean :offer_seatbelt
      t.boolean :securement
      t.boolean :ask_if_ready
      t.boolean :remove_restraints
      t.boolean :check_brakes_off
      t.boolean :second_ask_to_touch
      t.boolean :second_check_brakes_on
      t.boolean :ask_if_all_set_on_lift
    end
  end
end
