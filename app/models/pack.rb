class Pack < ActiveRecord::Base
  belongs_to :series
  belongs_to :player
end
