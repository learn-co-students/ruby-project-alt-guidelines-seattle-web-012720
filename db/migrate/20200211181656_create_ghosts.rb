class CreateGhosts < ActiveRecord::Migration[5.2]
  def change
      create_table :ghosts do |element|
          element.string :name
          element.integer :location_id
      end
  end
end