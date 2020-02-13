class AddColumnToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :unlocked, :boolean, :default => nil
  end
end
