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

ActiveRecord::Schema[7.0].define(version: 2022_05_03_102323) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carriage_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carriages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "carriage_type_id"
    t.integer "order_number"
    t.bigint "train_id"
    t.index ["carriage_type_id"], name: "index_carriages_on_carriage_type_id"
    t.index ["train_id"], name: "index_carriages_on_train_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "description"
    t.integer "value", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "passing_trains", force: :cascade do |t|
    t.bigint "train_id"
    t.bigint "station_id"
    t.datetime "arrival_time"
    t.datetime "departure_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["station_id"], name: "index_passing_trains_on_station_id"
    t.index ["train_id"], name: "index_passing_trains_on_train_id"
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seats", force: :cascade do |t|
    t.integer "number", null: false
    t.boolean "is_taken", default: false, null: false
    t.bigint "carriage_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carriage_id"], name: "index_seats_on_carriage_id"
  end

  create_table "station_connections", force: :cascade do |t|
    t.bigint "station_id", null: false
    t.bigint "connected_station_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connected_station_id"], name: "index_station_connections_on_connected_station_id"
    t.index ["station_id"], name: "index_station_connections_on_station_id"
  end

  create_table "station_order_numbers", force: :cascade do |t|
    t.bigint "route_id", null: false
    t.bigint "station_id", null: false
    t.integer "order_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id", "order_number"], name: "index_station_order_numbers_on_route_id_and_order_number", unique: true
    t.index ["route_id"], name: "index_station_order_numbers_on_route_id"
    t.index ["station_id"], name: "index_station_order_numbers_on_station_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trains", force: :cascade do |t|
    t.bigint "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["route_id"], name: "index_trains_on_route_id"
  end

  create_table "user_infos", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "patronymic"
    t.string "phone_number"
    t.string "passport_code"
    t.bigint "user_id", null: false
    t.bigint "discount_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discount_id"], name: "index_user_infos_on_discount_id"
    t.index ["user_id"], name: "index_user_infos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carriages", "carriage_types"
  add_foreign_key "carriages", "trains"
  add_foreign_key "passing_trains", "stations"
  add_foreign_key "passing_trains", "trains"
  add_foreign_key "seats", "carriages"
  add_foreign_key "station_connections", "stations"
  add_foreign_key "station_connections", "stations", column: "connected_station_id"
  add_foreign_key "station_order_numbers", "routes"
  add_foreign_key "station_order_numbers", "stations"
  add_foreign_key "trains", "routes"
  add_foreign_key "user_infos", "discounts"
  add_foreign_key "user_infos", "users"
end
