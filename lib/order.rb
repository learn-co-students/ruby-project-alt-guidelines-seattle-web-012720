class Order < ActiveRecord::Base
    belongs_to :user
    has_many :order_pizzas
    has_many :pizzas, through: :order_pizzas

    def order_pizza(pizza) 
        self.pizzas << pizza
    end
end