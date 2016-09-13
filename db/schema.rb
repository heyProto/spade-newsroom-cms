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

ActiveRecord::Schema.define(version: 20160906042354) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "description_data", force: :cascade do |t|
    t.string   "seat_id"
    t.text     "hub_description"
    t.text     "desk_description"
    t.text     "role_description"
    t.text     "persona_description"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "filter_data", force: :cascade do |t|
    t.string   "seat_id"
    t.string   "slug"
    t.string   "hub"
    t.string   "desk"
    t.string   "seniority"
    t.string   "shifts"
    t.text     "skills",       default: "{}"
    t.text     "toolset",      default: "{}"
    t.string   "availability"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "seat_id"
    t.text     "names"
    t.string   "passphrase"
    t.text     "url"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reference_list", force: :cascade do |t|
    t.string   "genre"
    t.string   "value"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
