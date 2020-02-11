class Resident < ActiveRecord::Base
    has_many :spooks
    has_many :ghosts, through: :spooks
    belongs_to :locations

    def new_resident
        
    end
    
    def where_am_i

    end

    def where_is(resident)

    end

    def search_basement_key

    end

end