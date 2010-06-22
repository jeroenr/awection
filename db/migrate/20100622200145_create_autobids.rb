class CreateAutobids < ActiveRecord::Migration
  def self.up
    create_table :autobids do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :autobids
  end
end
