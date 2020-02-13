class Order < ActiveRecord::Base
    belongs_to :user
    has_one :pizza

    def order_pizza(pizza) 
        self.pizza = pizza
    end
end