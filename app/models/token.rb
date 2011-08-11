class Token < ActiveRecord::Base

  belongs_to :player
  belongs_to :character
  belongs_to :trades_tokens

end
