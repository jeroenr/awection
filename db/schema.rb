# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100626145615) do

  create_table "accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "bids"
    t.integer  "price"
    t.integer  "auction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "address_types", :force => true do |t|
    t.string "name"
  end

  create_table "addresses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "address_type_id"
    t.string   "name"
    t.string   "address"
    t.string   "suburb"
    t.string   "city"
    t.string   "postcode"
    t.string   "state"
    t.integer  "country_id"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "genders", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "date_of_birth"
    t.integer  "gender_id"
    t.string   "email"
    t.boolean  "active"
    t.string   "key"
    t.boolean  "newsletter"
    t.boolean  "admin"
    t.boolean  "autobidder"
    t.string   "autobidder_bid_message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
