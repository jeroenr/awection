class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.integer   "parent_id"
      t.integer   "lft"
      t.integer   "rght"
      t.string    "name"
      t.string    "meta_description"
      t.string    "meta_keywords"
      t.string    "image"
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end

