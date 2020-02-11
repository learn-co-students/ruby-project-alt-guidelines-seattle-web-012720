class Toppings < ActiveRecord::Base
    belongs_to_many :pizza
end