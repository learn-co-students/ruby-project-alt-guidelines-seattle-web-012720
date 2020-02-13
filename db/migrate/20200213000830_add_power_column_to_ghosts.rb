class AddPowerColumnToGhosts < ActiveRecord::Migration[5.2]
  def change
    add_column :ghosts, :power, :integer, :default => 1
  end
end
