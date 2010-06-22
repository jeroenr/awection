class CreateAuctionImages < ActiveRecord::Migration
  def self.up
    create_table :auction_images do |t|
      t.integer   "auction_id"          # FK to auctions.id
      t.string    "image"
      t.integer   "order"
      t.timestamps
    end
  end

  def self.down
    drop_table :auction_images
  end
end

