class CreateAuctionImages < ActiveRecord::Migration
  def self.up
    create_table :auction_images do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :auction_images
  end
end
