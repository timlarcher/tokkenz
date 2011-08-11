class Bid < ActiveRecord::Base

  belongs_to :player
  belongs_to :trade

  has_many :bids_tokens, :foreign_key => "bid_id",
                           :dependent => :destroy,
                           :class_name => "BidToken"
  has_many :tokens, :through => :bids_tokens

end
