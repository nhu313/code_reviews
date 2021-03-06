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

ActiveRecord::Schema.define(version: 20131003161736) do

  create_table "review_replies", force: true do |t|
    t.string   "url"
    t.text     "comment"
    t.datetime "posted_date"
    t.integer  "review_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_requests", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "posted_date"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "reviewer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "archive",     default: false
  end

  create_table "skipped_review_requests", force: true do |t|
    t.integer  "user_id"
    t.datetime "last_skipped_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "uid"
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
