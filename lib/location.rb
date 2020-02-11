class Location < ActiveRecord::Base
    has_many :ghosts
    has_many :residents

    

end