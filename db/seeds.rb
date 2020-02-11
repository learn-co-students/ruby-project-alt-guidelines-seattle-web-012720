require 'pry'

20.times do
    User.create(name: Faker::Name.name)
end

str1 = "A pizza with Bell Pepper and Garlic.
A pizza with Canadian Bacon and Buffalo Meat.
A pizza with Carnitas and Bacon, topped with Swiss Cheese, Mascarpone, and White Sauce.
A pizza with Chicken, Egg, and Italian Spices, topped with Paneer and Bleu Cheese.
A pizza with Chipotle Pepper, Almonds, Clams, Hot Dogs, Egg, Pepperoni, and Buffalo Meat, topped with Cream Cheese.
A pizza with Ground Beef and Butter Chicken, topped with Parmesian.
A pizza with Red Pepper and Sweet Corn, topped with Havarti and Pesto Sauce.
A pizza with Shredded Carrots, Garbanzo Beans, Arugala, Mushrooms, Canadian Bacon, and Roasted Fennel.
A pizza with White Onion, Butternut Squash, Garlic, and Red Chillies, topped with Paneer and Tandoori Sauce.
A pizza with White Onion, Pinto Beans, Scallions, Chicken, Carnitas, Shrimp, and Pulled Pork, topped with Cheese Sauce."

str2 = "A pizza with Apple, Garbanzo Beans, White Onion, Buffalo Meat, Shrimp, Pepperoni, Sausage, Steak, and Red Chillies.
A pizza with Bell Pepper, Black Olives, Olives, and Hot Dogs.
A pizza with Butter Chicken, Salami, Linguica, and Jalapenos.
A pizza with Carmelized Onions, Spinach, Shredded Carrots, Cashews, and Bell Pepper, topped with Emmental and Bulgogi Sauce.
A pizza with Ham, Meatballs, Buffalo Meat, Pepperoni, and Hot Dogs, topped with Cheddar.
A pizza with Pulled Pork, Ground Beef, Hot Dogs, and Chicken, topped with Swiss Cheese.
A pizza with Red Pepper, Meatballs, and Short Rib Meat, topped with Paneer Sauce.
A pizza with Sausage, Pepperoni, and Linguica.
A pizza with Short Rib Meat and Hot Dogs, topped with Cheddar, Mascarpone, and Tobasco.
A pizza with Sweet Corn, Zucchini, Roasted Fennel, and Italian Spices, topped with Cheese Sauce."

str = str1 + str2
names = str.split(/\.\n|\./)
toppings = names.collect {|name| 
    name.split(/A pizza with |, and | and |, |topped with /).reject {
        |s| s.empty?}
    }
topping_class = toppings.flatten.uniq.sort()

index = 0
topping_class.length.times do
    Topping.create(name: topping_class[index])
    index += 1
end

index = 0
names.length.times do
    pizza = Pizza.create(name: names[index])
    counter = 0
    toppings[index].length.times do 
        pizza.toppings << Topping.find_by(name: toppings[index][counter])
    end
    index += 1
end

index = 0
20.times do
    num = rand(4)
    order = Order.create(user_id: User.all[index].id, num_pizzas: num)
    order.pizzas << Pizza.all[index]
    index += 1
end

