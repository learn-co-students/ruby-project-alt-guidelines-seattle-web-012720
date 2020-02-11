class CreateToppingsPizzas < ActiveRecord::Migration[5.1]
    def change
        create_table :toppings_pizzas, id: false do |t|
            t.belongs_to :toppings
            t.belongs_to :pizzas
        end
      end
end