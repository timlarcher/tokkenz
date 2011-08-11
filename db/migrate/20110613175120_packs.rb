class Packs < ActiveRecord::Migration
  def self.up
    create_table :packs do |t|
      t.integer :player_id
      t.integer :series_id
      t.integer :quantity
    end
  end

  def self.down
    drop_table :packs
  end
end
