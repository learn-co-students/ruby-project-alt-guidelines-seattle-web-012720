class Pizza < ActiveRecord::Base
    has_many :orders
    has_many :pizza_toppings
    has_many :toppings, through: :pizza_toppings
    
    def add_topping(topping)
        self.toppings << topping
    end

    def pizza_topping_helper(toppings)
        index = 0
        toppings.length.times do 
            self.toppings << toppings[index]
            index += 1
        end
        self
    end
end