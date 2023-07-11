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

ActiveRecord::Schema.define(version: 2023_07_11_044325) do

  create_table "event_favorites", force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_event_favorites_on_event_id"
    t.index ["user_id"], name: "index_event_favorites_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "vendor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_events_on_user_id"
    t.index ["vendor_id"], name: "index_events_on_vendor_id"
  end

  create_table "user_notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "vendor_id", null: false
    t.string "notification_type", null: false
    t.boolean "read_status", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
    t.index ["vendor_id"], name: "index_user_notifications_on_vendor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "address", null: false
    t.string "post_code", null: false
    t.string "phone_number", null: false
    t.boolean "is_delete", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendor_favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "vendor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_vendor_favorites_on_user_id"
    t.index ["vendor_id"], name: "index_vendor_favorites_on_vendor_id"
  end

  create_table "vendor_notifications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "vendor_id", null: false
    t.integer "event_id", null: false
    t.string "notification_type", null: false
    t.boolean "read_status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_vendor_notifications_on_event_id"
    t.index ["user_id"], name: "index_vendor_notifications_on_user_id"
    t.index ["vendor_id"], name: "index_vendor_notifications_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.integer "user_id", null: false
    t.boolean "vendor_is_delete", default: false, null: false
    t.integer "payment_method", null: false
    t.integer "invoice_amount", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_vendors_on_user_id"
  end

  add_foreign_key "event_favorites", "events"
  add_foreign_key "event_favorites", "users"
  add_foreign_key "events", "users"
  add_foreign_key "events", "vendors"
  add_foreign_key "user_notifications", "users"
  add_foreign_key "user_notifications", "vendors"
  add_foreign_key "vendor_favorites", "users"
  add_foreign_key "vendor_favorites", "vendors"
  add_foreign_key "vendor_notifications", "events"
  add_foreign_key "vendor_notifications", "users"
  add_foreign_key "vendor_notifications", "vendors"
  add_foreign_key "vendors", "users"
end
