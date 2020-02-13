
#run rake db:seed to run 

Tea.destroy_all
Tea.reset_pk_sequence
Topping.destroy_all
Topping.reset_pk_sequence
User.destroy_all
User.reset_pk_sequence
Drink.destroy_all
Drink.reset_pk_sequence


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


random_drink = Drink.all.sample.id

#Users 

nicole = User.create(name:"Nicole", drink_id: random_drink)
greg = User.create(name:"Greg", drink_id: random_drink)
dan = User.create(name: "Dan", drink_id: random_drink)
ophelia = User.create(name: "Ophelia", drink_id: random_drink)
william = User.create(name:"William", drink_id: random_drink)
sam = User.create(name:"Sam", drink_id: random_drink)
nick = User.create(name:"Nick", drink_id: random_drink)
dave = User.create(name:"Dave", drink_id: random_drink)




#Drinks

random_topping = Topping.all.sample.id 
random_tea = Tea.all.sample.id 

drink1 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)
drink2 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)
drink3 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)
drink4 = Drink.create(tea_id: random_tea, topping_id: nil, total: 3.5)
drink5 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)
drink6 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)
drink7 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)
drink8 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)
drink9 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)
drink10 = Drink.create(tea_id: random_tea, topping_id: random_topping, total: 5)