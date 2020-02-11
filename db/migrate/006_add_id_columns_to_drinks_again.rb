class AddIdColumnsToDrinksAgain < ActiveRecord::Migration[5.2]

    def change 
        add_column :drinks, :topping_id, :integer 
    end 

end 