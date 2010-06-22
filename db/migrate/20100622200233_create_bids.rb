class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer   "user_id"
      t.integer   "auction_id"
      t.string    "description"
      t.integer   "credit"
      t.integer   "debit"
      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end

