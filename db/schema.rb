# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_11_140754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "dealer_id", null: false
    t.string "street", null: false
    t.string "city", null: false
    t.string "zipcode", null: false
    t.string "country", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city"], name: "ix_addresses_city"
    t.index ["country"], name: "ix_addresses_country"
    t.index ["dealer_id"], name: "id_addresses_dealer_id"
    t.index ["street", "city", "country", "zipcode"], name: "ux_addresses", unique: true
    t.index ["zipcode"], name: "ix_addresses_zipcode"
  end

  create_table "dealers", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "phone", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "ux_dealers_name", unique: true
    t.index ["phone"], name: "ux_dealers_phone", unique: true
  end

  add_foreign_key "addresses", "dealers", name: "fk_addresses_dealer_id"
end
