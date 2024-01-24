# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[6.1].define(version: 2021_02_19_134558) do

  create_table "buses", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_buses_on_number", unique: true
  end

  create_table "circle_check_scores", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "total_defects"
    t.integer "defects_found"
    t.integer "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_circle_check_scores_on_participant_id", unique: true
  end

  create_table "distance_targets", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "x"
    t.integer "y"
    t.integer "direction"
    t.integer "intervals"
    t.integer "multiplier"
    t.integer "maneuver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "minimum"
  end

  create_table "maneuver_participants", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "maneuver_id"
    t.integer "participant_id"
    t.string "obstacles_hit"
    t.boolean "completed_as_designed"
    t.integer "reversed_direction"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "speed_achieved"
    t.string "distances_achieved"
    t.boolean "made_additional_stops"
    t.index ["maneuver_id", "participant_id"], name: "index_maneuver_participants_on_maneuver_id_and_participant_id", unique: true
  end

  create_table "maneuvers", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sequence_number"
    t.integer "speed_target"
    t.boolean "counts_additional_stops"
    t.index ["name"], name: "index_maneuvers_on_name", unique: true
    t.index ["sequence_number"], name: "index_maneuvers_on_sequence_number", unique: true
  end

  create_table "obstacles", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "x"
    t.integer "y"
    t.integer "point_value"
    t.integer "maneuver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "obstacle_type"
  end

  create_table "onboard_judgings", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "participant_id"
    t.integer "score"
    t.integer "seconds_elapsed"
    t.integer "missed_turn_signals"
    t.integer "missed_horn_sounds"
    t.integer "missed_flashers"
    t.integer "times_moved_with_door_open"
    t.integer "unannounced_stops"
    t.integer "sudden_stops"
    t.integer "abrupt_turns"
    t.boolean "speeding"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "minutes_elapsed"
    t.integer "sudden_starts"
    t.index ["participant_id"], name: "index_onboard_judgings_on_participant_id", unique: true
  end

  create_table "participants", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "bus_id"
    t.index ["name"], name: "index_participants_on_name", unique: true
    t.index ["number"], name: "index_participants_on_number", unique: true
  end

  create_table "quiz_scores", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.float "points_achieved"
    t.float "total_points"
    t.integer "participant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_id"], name: "index_quiz_scores_on_participant_id", unique: true
  end

  create_table "users", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "judge", default: false, null: false
    t.boolean "quiz_scorer", default: false, null: false
    t.boolean "circle_check_scorer", default: false, null: false
    t.boolean "master_of_ceremonies", default: false, null: false
    t.boolean "admin", default: false, null: false
    t.boolean "approved", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "versions", id: :integer, charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
