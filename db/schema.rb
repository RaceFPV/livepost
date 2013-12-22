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

ActiveRecord::Schema.define(version: 20131222033603) do

  create_table "chatlogs", force: true do |t|
    t.text     "chatname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "administrators"
    t.boolean  "privatechat"
    t.text     "permitted"
    t.string   "slug"
  end

  add_index "chatlogs", ["slug"], name: "index_chatlogs_on_slug", unique: true

  create_table "chatposts", force: true do |t|
    t.text     "post"
    t.text     "user_name"
    t.integer  "chatlog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "chatposts", ["user_id"], name: "index_chatposts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.datetime "lastseen"
    t.string   "twitter_id"
    t.string   "linkedin"
    t.string   "location"
    t.string   "facebook"
    t.string   "SuperUser"
    t.string   "super_user"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
