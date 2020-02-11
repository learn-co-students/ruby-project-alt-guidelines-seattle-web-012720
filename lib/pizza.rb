class Pizza < ActiveRecord::Base
    has_many :orders_pizzas
    #has_and_belongs_to_many :toppings
    has_many :orders, through: :orders_pizzas
end