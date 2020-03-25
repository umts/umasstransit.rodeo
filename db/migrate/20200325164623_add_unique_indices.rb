# frozen_string_literal: true

class AddUniqueIndices < ActiveRecord::Migration[5.2]
  def change
    [%i[buses number],
     %i[circle_check_scores participant_id],
     [:maneuver_participants, %i[maneuver_id participant_id]],
     %i[maneuvers name],
     %i[maneuvers sequence_number],
     %i[onboard_judgings participant_id],
     %i[participants number],
     %i[participants name],
     %i[quiz_scores participant_id],
     %i[users name]].each do |table, columns|
       add_index table, columns, unique: true
     end
  end
end
