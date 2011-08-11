class BidToken < ActiveRecord::Base

  set_table_name "bids_tokens"

  belongs_to :bid
  belongs_to :token

  validates :bid_id, :presence => true
  validates :token_id, :presence => true

end
