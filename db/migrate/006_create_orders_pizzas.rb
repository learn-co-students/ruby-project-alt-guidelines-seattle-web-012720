class CreateOrdersPizzas < ActiveRecord::Migration[5.1]
    def change
        create_table :orders_pizzas do |t|
            t.integer :order_id
            t.integer :pizza_id
        end
      end
end