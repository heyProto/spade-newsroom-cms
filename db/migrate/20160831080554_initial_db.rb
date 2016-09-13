class InitialDb < ActiveRecord::Migration
  def change

    create_table "description_data", force: :cascade do |t|
      t.string   "seat_id"
      t.text     "hub_description"
      t.text     "desk_description"
      t.text     "role_description"
      t.text     "persona_description"
      t.integer  "updated_by"
      t.integer  "created_by"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
    end

    create_table "filter_data", force: :cascade do |t|
      t.string   "seat_id"
      t.string   "slug"
      t.string   "hub"
      t.string   "desk"
      t.string   "seniority"
      t.string   "shifts"
      t.string   "skills", array: true, default: []
      t.string   "toolset", array: true, default: []
      t.string   "availability"
      t.integer  "updated_by"
      t.integer  "created_by"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
    end

    create_table "permissions", force: :cascade do |t|
      t.string   "seat_id"
      t.string   "name"
      t.string   "passphrase"
      t.text     "url"
      t.integer  "updated_by"
      t.integer  "created_by"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
    end

  end
end
