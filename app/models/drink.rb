class Drink < ActiveRecord::Base 
    belongs_to :tea
    belongs_to :topping

    #create instance of drink 
    

end 