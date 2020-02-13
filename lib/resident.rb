class Resident < ActiveRecord::Base
    has_many :spooks
    has_many :ghosts, through: :spooks
    belongs_to :locations

    def self.list_family
        Resident.all.each_with_index do |resident, index|
            puts (index + 1).to_s.bold + ".\t#{resident.name}".red
        end
    end

    def self.miranda_location
        Resident.find_by(name: "Miranda").location_id
    end

    def self.where_am_i
        location = Location.find(Resident.miranda_location).name
        puts "\nYou are currently in the #{location}".red
    end

    def self.sanity
        sanity = Resident.find_by(name: "Miranda").sanity
        puts "\nYour sanity is currently #{sanity}".red
        if sanity > 3 
            puts "\nYou're feeling great!".red
        elsif sanity == 3 
            puts "\nYou're calm and collected.".red
        elsif sanity == 2 
            puts "\nYour heart is pounding, you should hurry.".red
        elsif sanity == 1
            puts "\nYour vision is blurry and head is pounding.".red
            puts "Voices are whispering to you in a strange language.".red
        end
    end

    def residents_in_room(location)
        residents_in_room = Resident.where(location_id: location)
    end

    def ghosts_in_room(location)
        ghosts_in_room = Ghost.where(location_id: location)
    end

    def self.move_all_residents
        Resident.all.map do |resident| 
            resident.location_id = rand(Location.all[0].id..Location.all[4].id)
        end        
    end

    def check_current_room

    end

    def self.move_to(room)
        room = room.titleize

        if Location.find(Resident.miranda_location).name == room

            puts "\nYou're already in the #{room}. You don't have time for this!".red
            puts "type 'help' to see a list of available commands"

        elsif Location.all.any? {|location| room == location.name} && Location.find(Resident.miranda_location).name != room

            if room == "Attic" && Location.find_by(name: room).unlocked == false
                puts "\nYou need to find the entrance to the attic first!".red
                puts "Maybe try searching rooms for clues?".red
                return
            end

            if room == "Attic" && Location.find_by(name: room).unlocked == true
                puts "\nYou push open the hatch and a cloud of dust swirls past you.".red
                puts "All hairs on your body stand on end in unison and you pulse".red
                puts "skyrockets. After moments of silence you decide the coast is clear".red
                puts "and jump into the dark room.".red

                Resident.move_all_residents
                Ghost.move_all_ghosts
                
                miranda = Resident.find_by(name: "Miranda")
                new_location = Location.find_by(name: room).id

                miranda.update(location_id: new_location)
                return
            end

            if room == "Basement" && Location.find_by(name: room).unlocked == false
                puts "\nAlthough the lock is rusty and old, it is still strong.".red
                puts "You need to find the key before you can open the door.".red
                puts "Maybe try searching rooms for clues?".red
                return
            end

            if room == "Basement" && Location.find_by(name: room).unlocked == true
                puts "\nThe key fits! Silence is broken by the tumbling of the deadbolt".red
                puts "and the door creaking open. You take a deep breath and descend".red
                puts "into the darkness.".red

                Resident.move_all_residents
                Ghost.move_all_ghosts

                miranda = Resident.find_by(name: "Miranda")
                new_location = Location.find_by(name: room).id

                miranda.update(location_id: new_location)
                return
            end

            Resident.move_all_residents
            Ghost.move_all_ghosts

            miranda = Resident.find_by(name: "Miranda")
            new_location = Location.find_by(name: room).id

            miranda.update(location_id: new_location)

            puts "\nYou're now in the #{room}".red
            puts "However, on your way you heard other footsteps.".red

        else
            puts "\nThat isn't a valid room! You don't have time for this!".red
            puts "Type 'help' to see a list of available commands"
        end
    end

    def self.search
        location = Location.find(Resident.miranda_location).name
        case location
        when "Master Bedroom"
            puts "\nA king sized bed with fresh linnens. A wooden dresser, a bedside ".red
            puts "table, a lamp, A STRANGE WOMA - nevermind thats a mirror.".red
            sleep(3)
            puts "There's nothing out of the ordinary here.".red
        when "Secondary Bedroom"
            if Location.find_by(name: "Attic").unlocked == false
                Location.find_by(name: "Attic").update(unlocked: true)
            end
            puts "\nAfter meticulously examining the ceiling you notice an uneven crease".red
            puts "tucked under the layers of paint. You grab one of Olivia's dolls".red
            puts "and use it to peel it away layer by layer. An old hatch to the".red
            sleep(3)
            puts "attic is revealed.".red
            sleep(2)
            puts "\nYou can now move to the attic.".red

            Resident.move_all_residents
            Ghost.move_all_ghosts
        when "Bathroom"
            puts "\nYou pull back the shower curtain in one swift motion.".red
            puts "There's nothing. You exhale and collect your thoughts.".red
            sleep(3)
            puts "There's nothing out of the ordinary here.".red
        when "Kitchen"
            puts "\nPots and pans bang, dishes and glasses crash. You find".red
            puts "nothing of note, but worry you've made too much of a ruccus.".red
            sleep(3)
            puts "There's nothing out of the ordinary here.".red
        when "Living Room"
            if Location.find_by(name: "Basement").unlocked == false
                Location.find_by(name: "Basement").update(unlocked: true)
            end
            puts "\nYou frantically search the room for anything that could be helpful".red
            puts "After tossing the cushions off of the couch you find an old and rusty".red
            puts "key.".red
            sleep(2)
            puts "\nYou can now move to the basement.".red
        when "Attic"
            if Resident.find_by(name: "Miranda").knowledge == false
                Resident.find_by(name: "Miranda").update(knowledge: true)
                Resident.increment_counter(:sanity, Resident.find_by(name: "Miranda").id)
            end

            puts "\nThe air is thick with dust and decay. As you look around the attic".red
            puts "you stumble upon a group of strange archaic symbols carved.".red
            puts "into the floor. As you look closer you notice a word is faintly".red
            puts "glowing with a redish hue.".red
            sleep(3)
            puts "\nBael".bold.red
            sleep(2)
            puts "\nNow you know it's name. You're getting closer.".red
        when "Basement"
            if Resident.find_by(name: "Miranda").book == false
                Resident.find_by(name: "Miranda").update(book: true)
                Resident.increment_counter(:sanity, Resident.find_by(name: "Miranda").id)
            end

            puts "\nAfter making your way down the creaky wooden stairs".red
            puts "you see a black fog spewing from the brick wall on the".red
            puts "other side of the room.".red
            sleep(3)
            puts "\nYou peel away some loose bricks and pull out a dusty".red
            puts "book. As you wipe your hand across the cover you feel".red
            puts "it pulse as if it's alive. You open it and examine the".red
            puts "pages. The text isn't in english yet you have no problem".red
            puts "reading it.".red
            sleep(7)
            puts "\nYou can now banish the spirit if you know its name.".red
        end
    end

end