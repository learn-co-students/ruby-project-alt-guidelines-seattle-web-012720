class CreateTablePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :clues_available, :default => 3
      t.integer :correct_counter, :default => 0.to_i
      t.float :score
    end
  end
end
