class Store < ActiveRecord::Base

  belongs_to :player
  has_many :series
  has_many :stars

end
