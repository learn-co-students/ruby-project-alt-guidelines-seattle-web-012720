require_relative '../config/environment'

Ghost.delete_all
Resident.delete_all
Location.delete_all
Spook.delete_all

master_bedroom = Location.create(name: "Master Bedroom")
olivias_room = Location.create(name: "Olivia's Room")
living_room = Location.create(name: "Living Room")
bathroom = Location.create(name: "Bathroom")
kitchen = Location.create(name: "Kitchen")
attic = Location.create(name: "Attic", unlocked: false)
basement = Location.create(name: "Basement", unlocked: false)

# Bael always starts in the attic
bael = Ghost.create(name: "Bael", location_id: Location.all.third.id)

# Residents can start anywhere besides the attic or basement
miranda = Resident.create(name: "Miranda", location_id: Location.all[0].id, sanity: 3, book: false, knowledge: false)
aaron = Resident.create(name: "Aaron", location_id: rand(Location.all[0].id..Location.all[4].id), sanity: 2)
olivia = Resident.create(name: "Olivia", location_id: Location.all[0].id, sanity: 2)
mittens = Resident.create(name: "Mittens", location_id: rand(Location.all[0].id..Location.all[4].id), sanity: 1)
spot = Resident.create(name: "Spot", location_id: rand(Location.all[0].id..Location.all[4].id), sanity: 1)