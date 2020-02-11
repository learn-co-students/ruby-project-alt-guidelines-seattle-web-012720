class CreateResidents < ActiveRecord::Migration[5.2]
  def change
      create_table :residents do |element|
          element.string :name
          element.integer :location_id
      end
  end
end