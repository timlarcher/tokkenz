class AddQuantityIssuedToCharacters < ActiveRecord::Migration
  def self.up
    add_column :characters, :quantity_issued, :integer
  end

  def self.down
    remove_column :characters, :quantity_issued
  end
end
