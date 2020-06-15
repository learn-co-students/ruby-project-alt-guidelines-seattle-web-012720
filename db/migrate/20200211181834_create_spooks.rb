class CreateSpooks < ActiveRecord::Migration[5.2]
  def change
      create_table :spooks do |element|
          element.integer :ghost_id
          element.integer :resident_id
      end
  end
end