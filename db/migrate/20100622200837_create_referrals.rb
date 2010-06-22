class CreateReferrals < ActiveRecord::Migration
  def self.up
    create_table :referrals do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :referrals
  end
end
