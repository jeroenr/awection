class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.integer   "user_id"       # FK to users.id
      t.integer   "address_type_id"
      t.string    "name"
      t.string    "address_1"
      t.string    "address_2"
      t.string    "suburb"
      t.string    "city"
      t.string    "postcode"
      t.integer   "country_id"  # FK to countries.id
      t.string    "phone"
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end

