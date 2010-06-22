class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.string    "title"
      t.string    "meta_description"
      t.string    "meta_keywords"
      t.string    "description"
      t.integer   "category_id"   # FK to categories.id
      t.datetime  "start_time"
      t.datetime  "end_time"
      t.float     "rrp"
      t.float     "start_price"
      t.integer   "featured"      # ORI: tinyint(1)
      t.float     "delivery_cost"
      t.string    "delivery_information"
      t.integer   "peak_only"     # ORI: tinyint(1)
      t.float     "fixed_price"
      t.float     "minimum_price"
      t.integer   "time_extended"
      t.integer   "time_before_extended"
      t.integer   "autobid"       # ORI: tinyint(1)
      t.integer   "autobid_limit"
      t.integer   "current_limit"
      t.integer   "extend_enabled"  # ORI: tinyint(1)
      t.integer   "winner_id"
      t.integer   "status_id"
      t.integer   "closed"          # ORI: tinyint(1)
      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end

