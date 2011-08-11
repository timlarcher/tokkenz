class Tokens < ActiveRecord::Migration
  def self.up
    create_table :tokens do |t|
      t.integer :player_id
      t.integer :series_id
      t.integer :character_id
    end
  end

  def self.down
    drop_table :tokens
  end
end
