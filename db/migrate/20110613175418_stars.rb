class Stars < ActiveRecord::Migration
  def self.up
    create_table :stars do |t|
      t.string :name
      t.string :image
      t.text   :description
      t.date   :birth_date
      t.date   :death_date
      t.string :birthplace
    end
  end

  def self.down
    drop_table :stars
  end
end
