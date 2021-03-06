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

ActiveRecord::Schema.define(version: 20140816193151) do

  create_table "checkpoints", force: true do |t|
    t.string   "message"
    t.text     "success"
    t.text     "response"
    t.integer  "points",     default: 0
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "checkpoints", ["message"], name: "index_checkpoints_on_message", unique: true

  create_table "logs", force: true do |t|
    t.integer  "checkpoint_id"
    t.integer  "team_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["checkpoint_id"], name: "index_logs_on_checkpoint_id"
  add_index "logs", ["person_id"], name: "index_logs_on_person_id"
  add_index "logs", ["team_id"], name: "index_logs_on_team_id"

  create_table "people", force: true do |t|
    t.string   "number"
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["number"], name: "index_people_on_number"
  add_index "people", ["team_id"], name: "index_people_on_team_id"

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "position",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["code"], name: "index_teams_on_code", unique: true

end
