class BidsTokens < ActiveRecord::Migration
  def self.up
    create_table :bids_tokens do |t|
      t.integer :bid_id
      t.integer :token_id
      t.timestamps
    end
    add_index :bids_tokens, :bid_id
    add_index :bids_tokens, :token_id
    add_index :bids_tokens, [:bid_id, :token_id], :unique => true
  end

  def self.down
    drop_table :bids_tokens
  end
end
