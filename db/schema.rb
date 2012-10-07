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

ActiveRecord::Schema.define(:version => 20120928094120) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "system"
    t.datetime "begins_at"
    t.string   "duration"
    t.text     "description",        :limit => 255
    t.string   "descr_short"
    t.datetime "deadline"
    t.integer  "status"
    t.string   "location"
    t.integer  "max_player_num",                    :default => 0
    t.integer  "min_player_num",                    :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at",                                           :null => false
    t.boolean  "invite_only",                       :default => false
    t.boolean  "reservation_locked",                :default => false
  end

  add_index "events", ["begins_at"], :name => "index_events_on_begins_at"
  add_index "events", ["name"], :name => "index_events_on_name"
  add_index "events", ["user_id"], :name => "index_events_on_user_id"

  create_table "events_groups", :id => false, :force => true do |t|
    t.integer "group_id", :null => false
    t.integer "event_id", :null => false
  end

  add_index "events_groups", ["group_id", "event_id"], :name => "index_events_groups_on_group_id_and_event_id", :unique => true

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.string   "location"
    t.string   "website_url"
    t.string   "image_url"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "is_convention", :default => false
    t.string   "mailing_list"
  end

  add_index "groups", ["name"], :name => "index_groups_on_name", :unique => true

  create_table "interests", :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
    t.boolean "is_visible", :default => true
    t.boolean "is_banned",  :default => false
    t.boolean "gets_email", :default => true
  end

  add_index "interests", ["group_id"], :name => "index_interests_on_group_id"
  add_index "interests", ["user_id", "group_id"], :name => "index_interests_on_user_id_and_group_id", :unique => true
  add_index "interests", ["user_id"], :name => "index_interests_on_user_id"

  create_table "invitations", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "pending",     :default => true
    t.boolean  "accepted",    :default => false
    t.datetime "valid_until"
  end

  add_index "invitations", ["event_id"], :name => "index_invitations_on_event_id"
  add_index "invitations", ["user_id", "event_id"], :name => "index_invitations_on_user_id_and_event_id", :unique => true
  add_index "invitations", ["user_id"], :name => "index_invitations_on_user_id"

  create_table "reservations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.integer  "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reservations", ["user_id", "event_id"], :name => "index_reservations_on_user_id_and_event_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "nick"
    t.string   "description"
    t.string   "location"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "remember_token"
    t.boolean  "admin",          :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
