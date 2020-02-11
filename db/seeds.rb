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
aaron = Resident.create(name: "Aaron", location_id: rand(1..5))
miranda = Resident.create(name: "Miranda", location_id: rand(1..5))
olivia = Resident.create(name: "Olivia", location_id: rand(1..5))
alias :me :miranda
mittens = Resident.create(name: "Mittens", location_id: rand(1..5))
spot = Resident.create(name: "Spot", location_id: rand(1..5))