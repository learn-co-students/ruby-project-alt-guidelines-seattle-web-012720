class AddDrinkidColumnToUsers < ActiveRecord::Migration[5.2]

    def change 
        add_column :users, :drink_id, :integer 
    end 

end 