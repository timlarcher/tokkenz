class Trade < ActiveRecord::Base

  belongs_to :player
  has_many   :bids
  has_many   :trades_tokens, :foreign_key => "trade_id",
                             :dependent => :destroy,
                             :class_name => "TradeToken"
  has_many   :tokens, :through => :trades_tokens

end
