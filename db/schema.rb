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

ActiveRecord::Schema.define(:version => 20100624044020) do

  create_table "auctions", :force => true do |t|
    t.string   "title"
    t.string   "meta_description"
    t.string   "meta_keywords"
    t.text     "description"
    t.integer  "category_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.float    "rrp"
    t.float    "start_price"
    t.boolean  "featured"
    t.float    "delivery_cost"
    t.string   "delivery_information"
    t.boolean  "peak_only"
    t.float    "fixed_price"
    t.float    "minimum_price"
    t.integer  "time_extended"
    t.integer  "time_before_extended"
    t.boolean  "autobid"
    t.integer  "autobid_limit"
    t.integer  "current_limit"
    t.boolean  "extend_enabled"
    t.integer  "winner_id"
    t.integer  "status_id"
    t.boolean  "closed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
