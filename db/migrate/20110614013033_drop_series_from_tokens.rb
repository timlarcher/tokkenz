class DropSeriesFromTokens < ActiveRecord::Migration
  def self.up
    remove_column :tokens, :series_id
  end
  def self.down
    add_column :tokens, :series_id, :integer
  end
end