class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer :player_id
      t.integer :trade_id
      t.string  :name
      t.text    :description
      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
