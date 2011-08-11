class Series < ActiveRecord::Base

  def self.generate_pack ( series_id )
    # Reduce series pack count by one if possible. If not possible,
    # then return an error that no more packs in this series are
    # available. Otherwise, create a pack and return its id.
    # p = Pack.new
    # p.series_id = series_id
    # p.save
    # p
  end

end
