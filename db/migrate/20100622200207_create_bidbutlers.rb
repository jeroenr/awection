class CreateBidbutlers < ActiveRecord::Migration
  def self.up
    create_table :bidbutlers do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :bidbutlers
  end
end
