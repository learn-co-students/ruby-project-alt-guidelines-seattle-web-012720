class Tea < ActiveRecord::Base 
    has_many :drink 
    has_many :topping, through: :drink



end 