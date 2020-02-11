Ghost.delete_all
Resident.delete_all
Location.delete_all
Spook.delete_all

bedroom = Location.create(name: "Bedroom")
living_room = Location.create(name: "Living Room")
bathroom = Location.create(name: "Bathroom")
kitchen = Location.create(name: "Kitchen")
attic = Location.create(name: "Attic")
basement = Location.create(name: "Basement")

mr_spook = Ghost.create(name: "Mr. Spook")
mrs_spooky = Ghost.create(name: "Mrs. Spooky")
delbert_grady = Ghost.create(name: "Delbert Grady")

jack = Resident.create(name: "Jack", location_id: 4)
wendy = Resident.create(name: "Wendy", location_id: 3)
danny = Resident.create(name: "Danny", location_id: 1)
mittens = Resident.create(name: "Mittens", location_id: 2)
spot = Resident.create(name: "Spot", location_id: 2)