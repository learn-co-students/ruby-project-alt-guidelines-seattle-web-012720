class Location < ActiveRecord::Base
    has_many :ghosts
    has_many :residents

    def self.list_rooms
        Location.all.each_with_index do |location, index| 
            puts (index + 1).to_s.bold + ".\t#{location.name}".red
        end
    end
end