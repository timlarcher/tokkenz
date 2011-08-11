class TradeToken < ActiveRecord::Base

  set_table_name "trades_tokens"

  belongs_to :trade
  belongs_to :token

  validates :trade_id, :presence => true
  validates :token_id, :presence => true

end
