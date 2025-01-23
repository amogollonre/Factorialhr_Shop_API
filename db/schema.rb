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

ActiveRecord::Schema[8.0].define(version: 2025_01_26_004517) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "item_id", null: false
    t.jsonb "selected_options", default: {}, null: false
    t.decimal "final_price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id", "item_id"], name: "index_cart_items_on_cart_id_and_item_id", unique: true
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["item_id"], name: "index_cart_items_on_item_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status", limit: 50, default: "pending", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_carts_on_status"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name"
  end

  create_table "category_option_restrictions", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "if_characteristic_option_id", null: false
    t.bigint "then_characteristic_option_id", null: false
    t.string "restriction_type", limit: 50
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "if_characteristic_option_id", "then_characteristic_option_id"], name: "idx_category_option_restrictions_unique", unique: true
    t.index ["category_id"], name: "index_category_option_restrictions_on_category_id"
    t.index ["if_characteristic_option_id"], name: "idx_on_if_characteristic_option_id_33768e4ff9"
    t.index ["then_characteristic_option_id"], name: "idx_on_then_characteristic_option_id_3e941ff159"
  end

  create_table "characteristic_options", force: :cascade do |t|
    t.bigint "characteristic_id", null: false
    t.string "name", limit: 100, null: false
    t.text "description"
    t.decimal "price_adjustment", precision: 10, scale: 2, default: "0.0"
    t.boolean "in_stock", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characteristic_id", "name"], name: "index_characteristic_options_on_characteristic_id_and_name", unique: true
    t.index ["characteristic_id"], name: "index_characteristic_options_on_characteristic_id"
  end

  create_table "characteristics", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name", limit: 100, null: false
    t.text "description"
    t.boolean "required", default: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "name"], name: "index_characteristics_on_category_id_and_name", unique: true
    t.index ["category_id"], name: "index_characteristics_on_category_id"
  end

  create_table "item_characteristics", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "characteristic_id", null: false
    t.bigint "characteristic_option_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characteristic_id"], name: "index_item_characteristics_on_characteristic_id"
    t.index ["characteristic_option_id"], name: "index_item_characteristics_on_characteristic_option_id"
    t.index ["item_id", "characteristic_id"], name: "index_item_characteristics_on_item_id_and_characteristic_id", unique: true
    t.index ["item_id"], name: "index_item_characteristics_on_item_id"
  end

  create_table "item_images", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.string "url", limit: 255, null: false
    t.string "alt_text", limit: 255
    t.boolean "is_main", default: false
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id", "display_order"], name: "index_item_images_on_item_id_and_display_order", unique: true
    t.index ["item_id"], name: "index_item_images_on_item_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "name", limit: 100, null: false
    t.text "description"
    t.decimal "base_price", precision: 10, scale: 2
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["name"], name: "index_items_on_name"
  end

  create_table "option_images", force: :cascade do |t|
    t.bigint "characteristic_option_id", null: false
    t.string "url", limit: 255, null: false
    t.string "alt_text", limit: 255
    t.boolean "is_main", default: false
    t.integer "display_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["characteristic_option_id", "display_order"], name: "index_option_images_on_char_opt_id_and_display_order", unique: true
    t.index ["characteristic_option_id"], name: "index_option_images_on_characteristic_option_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "items"
  add_foreign_key "category_option_restrictions", "categories"
  add_foreign_key "category_option_restrictions", "characteristic_options", column: "if_characteristic_option_id"
  add_foreign_key "category_option_restrictions", "characteristic_options", column: "then_characteristic_option_id"
  add_foreign_key "characteristic_options", "characteristics"
  add_foreign_key "characteristics", "categories"
  add_foreign_key "item_characteristics", "characteristic_options"
  add_foreign_key "item_characteristics", "characteristics"
  add_foreign_key "item_characteristics", "items"
  add_foreign_key "item_images", "items"
  add_foreign_key "items", "categories"
  add_foreign_key "option_images", "characteristic_options"
end
