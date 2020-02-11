class Pizza < ActiveRecord::Base
    has_many :orders
    has_many :toppings
    has_many :users through: :orders
end