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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120513165650) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "system"
    t.datetime "begins_at"
    t.string   "duration"
    t.string   "description"
    t.string   "descr_short"
    t.datetime "deadline"
    t.integer  "status"
    t.string   "location"
    t.integer  "max_player_num", :default => 0
    t.integer  "min_player_num", :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "events", ["begins_at"], :name => "index_events_on_begins_at"
  add_index "events", ["name"], :name => "index_events_on_name"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "nick"
    t.string   "description"
    t.string   "location"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "remember_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
