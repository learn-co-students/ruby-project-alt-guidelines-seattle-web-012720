class Location < ActiveRecord::Base
    has_many :ghosts
    has_many :residents

    def self.list_rooms
        Location.all.each_with_index do |location, index| 
            puts (index + 1).to_s.bold + ".\t#{location.name}"
        end
    end

    def self.miranda_location
        Resident.find_by(name: "Miranda").location_id
    end

    def self.where_am_i
        location = Location.find(Resident.miranda_location).name
        puts "\nYou are currently in the #{location}"
    end

    def self.residents_in_room
        residents_in_room = Resident.where(location_id: miranda_location)
    end

    def self.ghosts_in_room
        ghosts_in_room = Ghost.where(miranda_location)
    end

    def self.move_all_residents
        Resident.all.map do |resident| 
            resident.location_id = rand(Location.all[0].id..Location.all[4].id)
        end        
    end

    def self.move_all_ghosts
        Ghost.all.map do |ghost|
            ghost.location_id = rand(Location.all[0].id..Location.all[6].id)
        end
    end

end