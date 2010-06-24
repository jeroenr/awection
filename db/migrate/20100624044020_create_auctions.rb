class CreateAuctions < ActiveRecord::Migration
  def self.up
    create_table :auctions do |t|
      t.string :title
      t.string :meta_description
      t.string :meta_keywords
      t.text :description
      t.integer :category_id
      t.datetime :start_time
      t.datetime :end_time
      t.float :rrp
      t.float :start_price
      t.boolean :featured
      t.float :delivery_cost
      t.string :delivery_information
      t.boolean :peak_only
      t.float :fixed_price
      t.float :minimum_price
      t.integer :time_extended
      t.integer :time_before_extended
      t.boolean :autobid
      t.integer :autobid_limit
      t.integer :current_limit
      t.boolean :extend_enabled
      t.integer :winner_id
      t.integer :status_id
      t.boolean :closed
      t.timestamps
    end
  end

  def self.down
    drop_table :auctions
  end
end

