class Resident < ActiveRecord::Base
    has_many :spooks
    has_many :ghosts, through: :spooks
    belongs_to :locations

    def self.list_family
        Resident.all.each_with_index do |resident, index|
            puts (index + 1).to_s.bold + ".\t#{resident.name}"
        end
    end

    def self.move_to(room)
        room = room.capitalize
        if Location.find(Resident.find_by(name: "Miranda").location_id).name == room
            puts "You're already in the #{room}"
        else
            Resident.all.map do |resident| 
                resident.location_id = rand(Location.all[0].id..Location.all[5].id)
            end

            Ghost.all.map do |ghost|
                ghost.location_id = rand(Location.all[0].id..Location.all[7].id)
            end

            Resident.find_by(name: "Miranda").location_id = Location.find_by(name: room).id

            puts "You're now in the #{room}"
            puts "However, on your way you heard other footsteps.".red
        end
    end

    def self.search

    end

end