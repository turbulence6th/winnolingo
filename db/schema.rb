# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160616231553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
  end

  create_table "request_languages", force: :cascade do |t|
    t.integer "request_id"
    t.integer "language_id"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "category"
    t.string   "name"
    t.string   "award"
    t.integer  "request_language_id"
    t.boolean  "privacy"
    t.text     "description"
    t.datetime "last_date"
    t.boolean  "extra_request"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "suggestions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "request_id"
    t.string   "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "swears", force: :cascade do |t|
    t.integer "language_id"
    t.string  "text"
  end

  create_table "user_languages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "language_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.uuid     "email_token"
    t.string   "password_digest"
    t.string   "name"
    t.integer  "gender"
    t.date     "birthday"
    t.text     "address"
    t.string   "mobile"
    t.uuid     "mobile_token"
    t.boolean  "show_followings", default: true
    t.boolean  "show_followers",  default: true
    t.integer  "role",            default: 2
    t.integer  "account_type"
    t.boolean  "bulletin"
    t.string   "facebook_id"
    t.string   "google_id"
    t.string   "twitter_id"
    t.boolean  "verified"
    t.boolean  "deleted"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", using: :btree

end
