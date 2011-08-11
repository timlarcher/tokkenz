class Series < ActiveRecord::Migration
  def self.up
    create_table :series do |t|
      t.string  :name
      t.string  :image
      t.text    :description
      t.integer :tokens_per_pack
      t.integer :packs_minted
      t.integer :packs_issued
      t.date    :release_date
      t.date    :term_date
    end
  end

  def self.down
    drop_table :series
  end
end
