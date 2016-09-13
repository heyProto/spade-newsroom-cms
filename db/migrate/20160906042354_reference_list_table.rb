class ReferenceListTable < ActiveRecord::Migration
  def change

    create_table "reference_list", force: :cascade do |t|
      t.string   "genre"
      t.string   "value"
      t.integer  "updated_by"
      t.integer  "created_by"
      t.datetime "created_at",                          null: false
      t.datetime "updated_at",                          null: false
    end

  end
end
