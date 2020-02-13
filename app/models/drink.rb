require 'pry'
class Drink < ActiveRecord::Base 
    belongs_to :tea
    belongs_to :topping, optional: true
    has_many :user



    #   find tea name by id 
    def self.find_tea_name_by_id(id)
        Tea.find(id).name
    end 

    #   find tea price by id
    def self.find_tea_price_by_id(id)
        tea_price = Tea.find(id).price 
    end 

    # find topping name by id 
    def self.find_topping_name_by_id(id)
        Topping.find(id).name 
    end 


    # find topping price by id 
    def self.find_topping_price_by_id(id)
        Topping.find(id).price 
    end 


    #   most popular tea (returns id)
    def self.popular_tea 
        tea_count = self.group(:tea_id).count
        most = tea_count.max_by{|id, amount| amount}
        most[0]
    end 

    # most popular topping  (returns id)
    def self.popular_topping 
        topping_count = self.group(:topping_id).count
        most = topping_count.max_by{|id, amount| amount}
        most[0]
    end 


    #   most popular drink (returns name)

    def self.most_popular_drink_name 
       puts  "#{self.find_tea_name_by_id(self.popular_topping)} with #{self.find_topping_name_by_id(self.popular_topping)}"
    end 

    #   most popular drink (returns name)

    def self.most_popular_drink_price 
        self.find_tea_price_by_id(self.popular_topping) + self.find_topping_price_by_id(self.popular_topping)
    end 

end 