class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer   "user_id"     # FK to users.id
      t.string    "name"
      t.integer   "bids"
      t.integer   "price"
      t.integer   "auction_id"  # FK to accounts.id
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end

