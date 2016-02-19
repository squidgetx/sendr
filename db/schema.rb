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

ActiveRecord::Schema.define(version: 20160219025220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "climbers", force: :cascade do |t|
    t.string   "name"
    t.integer  "ccs_id"
    t.integer  "college_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "climbers", ["ccs_id"], name: "index_climbers_on_ccs_id", unique: true, using: :btree

  create_table "climbs", force: :cascade do |t|
    t.integer  "scoresheet_id"
    t.integer  "route_id"
    t.integer  "attempts"
    t.string   "witness"
    t.boolean  "sent"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "colleges", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comps", force: :cascade do |t|
    t.string   "state"
    t.string   "location"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.integer  "comp_id"
    t.string   "name"
    t.string   "color"
    t.string   "location"
    t.string   "notes"
    t.integer  "points"
    t.string   "discipline"
    t.string   "grade"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scoresheets", force: :cascade do |t|
    t.integer  "climber_id"
    t.integer  "comp_id"
    t.integer  "boulder_score"
    t.integer  "sport_score"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.float    "speed_attempt1"
    t.float    "speed_attempt2"
    t.float    "speed"
  end

end
