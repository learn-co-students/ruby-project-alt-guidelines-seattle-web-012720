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
        room = room.titleize

        if Location.find(Resident.find_by(name: "Miranda").location_id).name == room

            puts "\nYou're already in the #{room}. You don't have time for this!"
            puts "type 'help' to see a list of available commands"

        elsif room == Location.all[0].name || Location.all[1].name || Location.all[2].name ||Location.all[3].name || Location.all[4].name
            Location.move_all_residents

            Location.move_all_ghosts

            Resident.find_by(name: "Miranda").location_id = Location.find_by(name: room).id

            puts "\nYou're now in the #{room}"
            puts "However, on your way you heard other footsteps.".red
        else
            puts "\nThat isn't a valid room! You don't have time for this!".red
            puts "type 'help' to see a list of available commands"
        end
    end

    def self.search
        current_room = 
    end

end