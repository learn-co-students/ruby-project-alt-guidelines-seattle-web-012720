class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to_many :pizzas
end