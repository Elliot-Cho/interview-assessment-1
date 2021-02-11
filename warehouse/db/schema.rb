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

ActiveRecord::Schema.define(version: 2021_02_11_194925) do

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.float "flat_fee", null: false
    t.integer "charge_type", null: false
    t.float "charge_value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discounts", force: :cascade do |t|
    t.float "percentage_off", null: false
    t.integer "item_coverage_from"
    t.integer "item_coverage_to"
    t.integer "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_discounts_on_customer_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.float "length", null: false
    t.float "width", null: false
    t.float "height", null: false
    t.float "weight"
    t.float "value"
    t.integer "customer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_items_on_customer_id"
  end

  add_foreign_key "discounts", "customers"
  add_foreign_key "items", "customers"
end
