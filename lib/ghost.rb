class Ghost < ActiveRecord::Base
    has_many :spooks
    has_many :residents, through: :spooks
    belongs_to :locations

    def name_reminder
        puts "\n#{self.name}".red
    end

    def self.move_all_ghosts
        Ghost.all.map do |ghost|
            ghost.location_id = rand(Location.all[0].id..Location.all[6].id)
        end
    end

    def ghosts_attack
        Ghost.all.map do |ghost|
            if residents_in_room(ghost.location_id)
                residents_in_room(ghost.location_id).map do |resident|
                    if resident.name == "Miranda"
                        if ghost.name == "Bael"
                            puts "\nA grotesque figure is standing in a corner of the room. Part".red
                            puts "man, part frog, part, cat. Yet always changing and shifting.".red
                            puts "Petrified with fear, you can only watch as it approaches. ".red
                            puts "Your vision fades and you lose consciousness.".red
                            sleep (10)
                            puts "\nYou wake up with a pounding head. You should probably".red
                            puts "check your sanity.".red
                        else
                            puts "\nIt's #{ghost.name}! But something is off. Their eyes".red
                            puts "are bloodshot and they look oddly pale. Before you have time to".red
                            puts "to react #{ghost.name} lets out a growl and lunges at you".red
                            sleep (8)
                            puts "\nYou wake up with a pounding head. You should probably".red
                            puts "check your sanity.".red
                        end
                    end
                    resident.update(sanity: sanity - ghost.power)
                    Spook.new(ghost.id, resident.id)
                end

                if residents_in_room(ghost.location_id).any? {|resident| resident.sanity < 1}
                    Resident.where("sanity < ?", 1).map do |resident|
                        if resident.name == "Miranda"
                            resident.destroy
                            CommandLineInterface.dead
                        else
                            Ghost.new(resident.name, resident.location_id)
                            puts "\nYou hear a horrible screech that sounds like it".red
                            puts "came from #{resident.name}, followed by a loud thud.".red
                            puts "After several seconds of silence the house rumbles.".red
                            puts "#{resident.name} gleefully calls to you, but".red 
                            puts "something about their voice sounds off.".red
                        end
                    end
                    ghost.update(power: power + 1)
                end
            end
        end
    end

    def self.banish
        Ghost.destroy((Ghost.find_by name: "Bael").id)
        puts "\n As you chant the strange words the entire house begins to".red
        puts "shake. What begins as a soft murmur transforms to an ear piercing".red
        puts "shriek. Bael appears before you. His body rapidly morphs from".red
        puts "the shape of a cat, a toad, a man, and various mixes of each.".red
        puts "A ghostly hand reaches out from the book, grabs Bael, and".red
        puts "pulls him into the pages. The book crumbles to ashes and a".red
        puts "silence falls over the house.".red
        sleep(10)
        puts "\nLife continues. You win!".cyan
        puts "Type quit whenever you're ready to exit.".cyan
    end

end