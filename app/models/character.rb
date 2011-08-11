class Character < ActiveRecord::Base
  belongs_to :series
  belongs_to :star
  has_many   :tokens
end
