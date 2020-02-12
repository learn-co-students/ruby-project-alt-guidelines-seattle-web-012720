class AddTotalColumnToDrinks < ActiveRecord::Migration[5.2]

    def change 
        add_column :drinks, :total, :integer 
    end 

end 