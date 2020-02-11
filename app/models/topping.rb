class Topping < ActiveRecord::Base
    has_many :drink 
    has_many :tea, through: :drink 


end 