# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170418203633) do

  create_table "buses", force: :cascade do |t|
    t.string   "number",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "circle_check_scores", force: :cascade do |t|
    t.integer  "total_defects",  limit: 4
    t.integer  "defects_found",  limit: 4
    t.integer  "participant_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "distance_targets", force: :cascade do |t|
    t.integer  "x",           limit: 4
    t.integer  "y",           limit: 4
    t.integer  "direction",   limit: 4
    t.integer  "intervals",   limit: 4
    t.integer  "multiplier",  limit: 4
    t.integer  "maneuver_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "name",        limit: 255
    t.integer  "minimum",     limit: 4
  end

  create_table "maneuver_participants", force: :cascade do |t|
    t.integer  "maneuver_id",           limit: 4
    t.integer  "participant_id",        limit: 4
    t.string   "obstacles_hit",         limit: 255
    t.boolean  "completed_as_designed"
    t.integer  "reversed_direction",    limit: 4
    t.integer  "score",                 limit: 4
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "speed_achieved"
    t.string   "distances_achieved",    limit: 255
    t.boolean  "made_additional_stops"
  end

  create_table "maneuvers", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "sequence_number",         limit: 4
    t.integer  "speed_target",            limit: 4
    t.boolean  "counts_additional_stops"
    t.boolean  "counts_reverses",                     default: false
    t.integer  "reverse_points",          limit: 4
  end

  create_table "obstacles", force: :cascade do |t|
    t.integer  "x",             limit: 4
    t.integer  "y",             limit: 4
    t.integer  "point_value",   limit: 4
    t.integer  "maneuver_id",   limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "obstacle_type", limit: 255
  end

  create_table "onboard_judgings", force: :cascade do |t|
    t.integer  "participant_id",             limit: 4
    t.integer  "score",                      limit: 4
    t.integer  "seconds_elapsed",            limit: 4
    t.integer  "missed_turn_signals",        limit: 4
    t.integer  "missed_horn_sounds",         limit: 4
    t.integer  "missed_flashers",            limit: 4
    t.integer  "times_moved_with_door_open", limit: 4
    t.integer  "unannounced_stops",          limit: 4
    t.integer  "sudden_stops",               limit: 4
    t.integer  "abrupt_turns",               limit: 4
    t.boolean  "speeding"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "minutes_elapsed",            limit: 4
    t.integer  "sudden_starts",              limit: 4
  end

  create_table "participants", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "number",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "bus_id",     limit: 4
  end

  create_table "quiz_scores", force: :cascade do |t|
    t.float    "points_achieved", limit: 24
    t.float    "total_points",    limit: 24
    t.integer  "participant_id",  limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "",    null: false
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "judge",                              default: false, null: false
    t.boolean  "quiz_scorer",                        default: false, null: false
    t.boolean  "circle_check_scorer",                default: false, null: false
    t.boolean  "master_of_ceremonies",               default: false, null: false
    t.boolean  "admin",                              default: false, null: false
    t.boolean  "approved",                           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
