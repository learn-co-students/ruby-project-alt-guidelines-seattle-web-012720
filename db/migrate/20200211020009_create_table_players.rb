class CreateTablePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :clues_available
      t.float :score
    end
  end
end
