user = User.create(name: "Jeff")
order = Order.create(user_id: user.id, num_pizzas: 2)
pizza = Pizza.create(name: "Pepperoni")
order.order_pizza(pizza)

topping = Topping.create(name: "pepperoni")
pizza.add_topping(topping)
pizza.toppings
