require 'pry'
class User < ActiveRecord::Base 

    belongs_to :drink

    #As a user, I want to create a tea order

    def create_tea_order(tea_id)
        new_drink = Drink.create(tea_id: tea_id) 
        self.drink_id = new_drink.id
    end 

 

    #User puts topping in tea(optional/update)

    def create_topping_order(topping_id) 
        current_drink = Drink.find(self.drink_id)
        current_drink.update(topping_id: topping_id)
    end 

    #User views drink
     
    def view_drinks
    "#{self.drink.tea.name} with #{self.drink.topping.name}"
    end 


    #As a user, I want to delete a drink order

    def delete_drink_order
        self.destroy 
    end 
end 