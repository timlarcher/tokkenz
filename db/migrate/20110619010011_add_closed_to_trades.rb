class AddClosedToTrades < ActiveRecord::Migration
  def self.up
    add_column :Trades, :closed, :boolean, :default => false
  end

  def self.down
    remove_column :Trades, :closed
  end
end
