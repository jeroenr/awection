class CreateAutobids < ActiveRecord::Migration
  def self.up
    create_table :autobids do |t|
      t.integer   "autobid_id"
      t.datetime  "deploy"
      t.datetime  "end_time"
      t.timestamps
    end
  end

  def self.down
    drop_table :autobids
  end
end

