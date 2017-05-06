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

ActiveRecord::Schema.define(version: 0) do

  create_table "administrators", force: :cascade do |t|
    t.text "name"
    t.text "password"
  end

  create_table "openhours", force: :cascade do |t|
    t.integer "restaurant_id"
    t.text    "mon_open"
    t.text    "mon_close"
    t.text    "tues_open"
    t.text    "tues_close"
    t.text    "wed_open"
    t.text    "wed_close"
    t.text    "thr_open"
    t.text    "thr_close"
    t.text    "fri_open"
    t.text    "fri_close"
    t.text    "sat_open"
    t.text    "sat_close"
    t.text    "sun_open"
    t.text    "sun_close"
    t.index ["restaurant_id"], name: "index_openhours_on_restaurant_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "reserve_at"
    t.datetime "dine_at"
    t.integer  "people"
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.text    "name"
    t.text    "address"
    t.integer "table_number"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "restaurant_id"
    t.integer  "user_id"
    t.datetime "updated_at"
    t.text     "content"
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.integer "restaurant_id"
    t.integer "table_order"
    t.integer "capacity"
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.text    "name"
    t.text    "password"
    t.integer "points"
    t.text    "email_address"
  end

end
