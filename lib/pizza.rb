class Pizza < ActiveRecord::Base
    has_and_belongs_to_many :orders
    has_and_belongs_to_many :toppings
    has_many :users, through: :orders
end