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

ActiveRecord::Schema[7.1].define(version: 2024_08_09_181403) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consumptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.date "date"
    t.string "meal_type"
    t.float "calories"
    t.json "macros"
    t.string "food_name"
    t.index ["user_id"], name: "index_consumptions_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.date "date"
    t.string "exercise_type"
    t.integer "duration"
    t.integer "calories_burnt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "age"
    t.string "sex"
    t.date "birthday"
    t.integer "height"
    t.integer "weight"
    t.integer "target_weight"
    t.date "target_date"
    t.integer "exercise_goals"
    t.string "current_activity_level"
    t.boolean "full_time_job"
    t.string "weight_loss_reason"
    t.boolean "subscribe_to_updates"
    t.string "name"
    t.float "current_weight"
    t.float "amr"
    t.float "bmr"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "consumptions", "users"
  add_foreign_key "exercises", "users"
end
