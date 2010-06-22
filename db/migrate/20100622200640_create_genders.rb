class CreateGenders < ActiveRecord::Migration
  def self.up
    create_table :genders do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :genders
  end
end
