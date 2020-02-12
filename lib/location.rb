class Location < ActiveRecord::Base
    has_many :ghosts
    has_many :residents

    def self.list_rooms
        Location.all.each_with_index do |location, index| 
            puts (index + 1).to_s.bold + ".\t#{location.name}"
        end
    end

    def self.where_am_i
        location = Location.find(Resident.find_by(name: "Miranda").location_id).name
        puts "\nYou are currently in the #{location}"
    end

    def self.residents_in_room
        residents_in_room = Resident.where(location_id: Resident.find_by(name: 'Miranda').location_id)
    end

    def self.ghosts_in_room
        ghosts_in_room = Ghost.where(location_id: Resident.find_by(name: 'Miranda').location_id)
    end

end