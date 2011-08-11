class CreateTrades < ActiveRecord::Migration
  def self.up
    create_table :trades do |t|
      t.integer :player_id
      t.string  :name
      t.text    :description
      t.timestamps
    end
  end

  def self.down
    drop_table :trades
  end
end
