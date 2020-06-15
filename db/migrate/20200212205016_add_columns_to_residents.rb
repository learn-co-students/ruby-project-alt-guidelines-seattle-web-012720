class AddColumnsToResidents < ActiveRecord::Migration[5.2]
  def change
    add_column :residents, :sanity, :integer
    add_column :residents, :book, :boolean, :default => nil
    add_column :residents, :knowledge, :boolean, :default => nil
  end
end
