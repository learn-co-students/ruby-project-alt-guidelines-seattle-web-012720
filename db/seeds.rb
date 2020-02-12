Ghost.delete_all
Resident.delete_all
Location.delete_all
Spook.delete_all

master_bedroom = Location.create(name: "Master Bedroom")
secondary_bedroom = Location.create(name: "Secondary Bedroom")
living_room = Location.create(name: "Living Room")
bathroom = Location.create(name: "Bathroom")
kitchen = Location.create(name: "Kitchen")
attic = Location.create(name: "Attic")
basement = Location.create(name: "Basement")

# Bael always starts in the attic
bael = Ghost.create(name: "Bael", location_id: 6)

# Residents can start anywhere besides the attic or basement
aaron = Resident.create(name: "Aaron", location_id: rand(Location.all[0].id..Location.all[5].id))
miranda = Resident.create(name: "Miranda", location_id: Location.all[0].id)
olivia = Resident.create(name: "Olivia", location_id: Location.all[0].id)
mittens = Resident.create(name: "Mittens", location_id: rand(Location.all[0].id..Location.all[5].id))
spot = Resident.create(name: "Spot", location_id: rand(Location.all[0].id..Location.all[5].id))