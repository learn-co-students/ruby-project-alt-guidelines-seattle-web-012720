
#run rake db:seed to run 

User.delete_all 
Tea.delete_all
Topping.delete_all 
Drink.delete_all 

#Teas
green = Tea.create(name: "Green Tea", price: 3.5)
black = Tea.create(name: "Black Tea", price: 3.5)
thai = Tea.create(name: "Thai Tea", price: 3.5)
white = Tea.create(name: "White Tea", price: 3.5)
wintermelon = Tea.create(name: "Winter Melon", price: 3.5)


#Toppings or Boba
boba = Topping.create(name: "Boba", price: 1.5)
mini = Topping.create(name: "Mini", price: 1.5)
popping = Topping.create(name: "Popping", price: 1.5)
coffeejelly = Topping.create(name: "Coffee Jelly", price: 1.5)
grassjelly = Topping.create(name: "Grass Jelly", price: 1.5)


#Users 
nicole = User.create(name:"Nicole")
greg = User.create(name:"Greg")
dan = User.create(name: "Dan")
ophelia = User.create(name: "Ophelia")
william = User.create(name:"William")


