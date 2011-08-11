class TradesTokens < ActiveRecord::Migration
  def self.up
    create_table :trades_tokens do |t|
      t.integer :trade_id
      t.integer :token_id
      t.timestamps
    end
    add_index :trades_tokens, :trade_id
    add_index :trades_tokens, :token_id
    add_index :trades_tokens, [:trade_id, :token_id], :unique => true
  end

  def self.down
    drop_table :trades_tokens
  end
end
