class CreatePizzasOrders < ActiveRecord::Migration[5.1]
    def change
        create_table :pizzas_orders, id: false do |t|
            t.belongs_to :pizzas
            t.belongs_to :orders
        end
      end
end