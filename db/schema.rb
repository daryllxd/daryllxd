# frozen_string_literal: true
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

ActiveRecord::Schema.define(version: 20170916190959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activity_tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "shortcut"
  end

  create_table "budget_tags", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "shortcut",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "expense_budget_tags", force: :cascade do |t|
    t.integer  "expense_id",    null: false
    t.integer  "budget_tag_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["budget_tag_id"], name: "index_expense_budget_tags_on_budget_tag_id", using: :btree
    t.index ["expense_id"], name: "index_expense_budget_tags_on_expense_id", using: :btree
  end

  create_table "expenses", force: :cascade do |t|
    t.string   "description", null: false
    t.integer  "amount",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pomodoro_activity_tags", force: :cascade do |t|
    t.integer  "pomodoro_id"
    t.integer  "activity_tag_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["activity_tag_id"], name: "index_pomodoro_activity_tags_on_activity_tag_id", using: :btree
    t.index ["pomodoro_id"], name: "index_pomodoro_activity_tags_on_pomodoro_id", using: :btree
  end

  create_table "pomodoros", force: :cascade do |t|
    t.integer  "duration",    null: false
    t.string   "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "weights", force: :cascade do |t|
    t.decimal  "value",       null: false
    t.date     "recorded_at", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_foreign_key "expense_budget_tags", "budget_tags"
  add_foreign_key "expense_budget_tags", "expenses"
  add_foreign_key "pomodoro_activity_tags", "activity_tags"
  add_foreign_key "pomodoro_activity_tags", "pomodoros"
end
