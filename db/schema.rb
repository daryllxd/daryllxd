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

ActiveRecord::Schema.define(version: 20180514145007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_tags", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "shortcut"
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.string "subtitle"
    t.string "amazon_url"
    t.string "authors", default: [], array: true
    t.string "description"
    t.string "google_books_url"
    t.string "thumbnail_url"
    t.jsonb "google_books_api_data"
    t.date "google_books_scraped_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budget_tags", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.string "shortcut", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_budget_tags", id: :serial, force: :cascade do |t|
    t.integer "expense_id", null: false
    t.integer "budget_tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["budget_tag_id"], name: "index_expense_budget_tags_on_budget_tag_id"
    t.index ["expense_id"], name: "index_expense_budget_tags_on_expense_id"
  end

  create_table "expenses", id: :serial, force: :cascade do |t|
    t.string "description", null: false
    t.integer "amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "spent_on", null: false
  end

  create_table "oauth_access_tokens", id: :serial, force: :cascade do |t|
    t.integer "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "pomodoro_activity_tags", id: :serial, force: :cascade do |t|
    t.integer "pomodoro_id"
    t.integer "activity_tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_tag_id"], name: "index_pomodoro_activity_tags_on_activity_tag_id"
    t.index ["pomodoro_id", "activity_tag_id"], name: "index_pomodoro_activity_tags_on_pomodoro_id_and_activity_tag_id", unique: true
    t.index ["pomodoro_id"], name: "index_pomodoro_activity_tags_on_pomodoro_id"
  end

  create_table "pomodoros", id: :serial, force: :cascade do |t|
    t.integer "duration", null: false
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "weights", id: :serial, force: :cascade do |t|
    t.decimal "value", null: false
    t.date "recorded_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "expense_budget_tags", "budget_tags"
  add_foreign_key "expense_budget_tags", "expenses"
  add_foreign_key "pomodoro_activity_tags", "activity_tags"
  add_foreign_key "pomodoro_activity_tags", "pomodoros"
end
