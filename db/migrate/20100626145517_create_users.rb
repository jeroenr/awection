class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :first_name
      t.string :last_name
      t.datetime :date_of_birth
      t.integer :gender_id
      t.string :email
      t.boolean :active
      t.string :key
      t.boolean :newsletter
      t.boolean :admin
      t.boolean :autobidder
      t.string :autobidder_bid_message

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
