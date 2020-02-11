class AddIdColumnsToDrinks < ActiveRecord::Migration[5.2]

    def change 
        add_column :drinks, :tea_id, :integer 
    end 

end 