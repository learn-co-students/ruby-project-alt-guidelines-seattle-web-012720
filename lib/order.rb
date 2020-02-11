class Order < ActiveRecord::Base
    belongs_to :user
    has_many :orders_pizzas
    has_many :pizzas, through: :orders_pizzas
end