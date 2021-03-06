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

ActiveRecord::Schema.define(version: 2020_03_08_054808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "animation_data", force: :cascade do |t|
    t.string "animation_name"
    t.float "animation_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "picture"
    t.bigint "category_id"
    t.json "animation_json"
    t.bigint "user_id"
    t.index ["category_id"], name: "index_animation_data_on_category_id"
    t.index ["user_id"], name: "index_animation_data_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.string "category_description"
    t.string "picture"
    t.bigint "primarycategory_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["primarycategory_id"], name: "index_categories_on_primarycategory_id"
  end

  create_table "user_animations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.bigint "user_id"
    t.bigint "animation_data_id"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "location"
    t.float "amount"
    t.integer "frequency"
    t.index ["animation_data_id"], name: "index_user_animations_on_animation_data_id"
    t.index ["user_id"], name: "index_user_animations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "contact_number"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role", default: "user"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "uuid"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
