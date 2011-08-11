class AddClosedToBids < ActiveRecord::Migration
  def self.up
    add_column :Bids, :closed, :boolean, :default => false
  end

  def self.down
    remove_column :Bids, :closed
  end
end
