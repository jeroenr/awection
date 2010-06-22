class CreateBidbutlers < ActiveRecord::Migration
  def self.up
    create_table :bidbutlers do |t|
      t.integer   "user_id"
      t.integer   "auction_id"
      t.float     "minimum_price"
      t.float     "maximum_price"
      t.integer   "bids"
      t.timestamps
    end
  end

  def self.down
    drop_table :bidbutlers
  end
end

