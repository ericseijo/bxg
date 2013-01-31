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

ActiveRecord::Schema.define(:version => 20130116230106) do

  create_table "clients", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.string   "name",          :null => false
    t.string   "ticker_symbol"
    t.string   "website"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "clients", ["user_id"], :name => "index_clients_on_user_id"

  create_table "plans", :force => true do |t|
    t.string   "level"
    t.decimal  "price",                        :precision => 8, :scale => 2, :null => false
    t.integer  "number_of_releases_per_month",                               :null => false
    t.string   "storage_space",                                              :null => false
    t.integer  "number_of_user_accounts",                                    :null => false
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "releases", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.string   "name",         :null => false
    t.string   "status",       :null => false
    t.string   "headline"
    t.string   "sub_headline"
    t.text     "body"
    t.string   "link"
    t.datetime "publish_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "releases", ["user_id"], :name => "index_releases_on_user_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "user_id",               :null => false
    t.integer  "plan_id",               :null => false
    t.string   "status",                :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "stripe_customer_token"
    t.datetime "canceled_at"
  end

  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.boolean  "admin",                  :default => false
    t.string   "address"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
