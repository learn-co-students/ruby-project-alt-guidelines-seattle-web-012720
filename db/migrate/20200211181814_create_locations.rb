class CreateLocations < ActiveRecord::Migration[5.2]
  def change
      create_table :locations do |element|
          element.string :name
      end
  end
end