class Location < ActiveRecord::Base
    has_many :ghosts
    has_many :residents

    def residents_in_room
        Resident.where(location_id == self.id)
    end

end