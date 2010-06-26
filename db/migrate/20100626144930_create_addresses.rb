class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer :user_id
      t.integer :address_type_id
      t.string :name
      t.string :address
      t.string :suburb
      t.string :city
      t.string :postcode
      t.string :state
      t.integer :country_id
      t.string :phone

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
