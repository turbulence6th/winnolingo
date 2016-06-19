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

ActiveRecord::Schema.define(version: 20160618203422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "language_id"
    t.text    "name"
    t.string  "answers",            array: true
    t.integer "right_answer_index"
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
    t.boolean  "privacy"
    t.text     "description"
    t.datetime "last_date"
    t.boolean  "extra_request"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "auth_token"
    t.string   "device_id"
    t.string   "device_type"
    t.string   "push_token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "sessions", ["auth_token"], name: "index_sessions_on_auth_token", using: :btree
  add_index "sessions", ["device_id"], name: "index_sessions_on_device_id", using: :btree
  add_index "sessions", ["device_type"], name: "index_sessions_on_device_type", using: :btree
  add_index "sessions", ["user_id"], name: "index_sessions_on_user_id", using: :btree

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
    t.string   "email_token"
    t.string   "password_digest"
    t.string   "name"
    t.integer  "account_type"
    t.date     "birthday"
    t.text     "address"
    t.string   "mobile"
    t.string   "mobile_token"
    t.boolean  "show_followings", default: true
    t.boolean  "show_followers",  default: true
    t.integer  "winno_point",     default: 0
    t.integer  "role",            default: 1
    t.boolean  "bulletin",        default: true
    t.string   "facebook_id"
    t.string   "google_id"
    t.string   "twitter_id"
    t.boolean  "verified",        default: false
    t.boolean  "deleted",         default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", using: :btree

end
