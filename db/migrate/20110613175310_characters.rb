class Characters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.integer :series_id
      t.integer :star_id
      t.string  :name
      t.string  :image
      t.text    :description
      t.integer :quantity
    end
  end

  def self.down
    drop_table :characters
  end
end
