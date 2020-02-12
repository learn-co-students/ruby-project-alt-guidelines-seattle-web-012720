class Cli

    ### initialize function
    def greet
        puts 'Welcome to Sliceline, the best way to order pizza!'
    end

    ### terminate function
    def self.goodbye
        puts 'Thanks for using Sliceline!'
    end

    def self.end 
        puts 'Is there anything else we can help you with? -- enter (Y/N)'
        Helper.gets_answer(Cli.do_you_have_an_order, Cli.goodbye)
    end

    ### pizza functions
    def self.remove_pizza(order)
        puts 'How many pizzas would you like to remove? -- enter a number'
        number = Helper.remove_pizza
        puts "You have removed #{number} pizza#{Helper.plural(number)}."
        number = order.num_pizzas
        value1 = Helper.plural(number)
        value2 = Helper.toppings_to_s(order.pizzas.toppings)
        if number = 0
            puts "You have nothing in your order"
        else
            puts "Your order is now: #{number} pizza#{value1} with #{value2}"
        end
        puts "Would you like to make any other changes to your order? -- enter (Y/N)"
        Helper.gets_anwser(Cli.change_order, Cli.end)
    end

    def self.add_pizza(order)
        puts 'You have selected "ADD a pizza"'
        puts 'Enter the number of pizzas you would like to add'
        number = Helper.get_number
        order.num_pizzas += number
    end

    ### order functions

    def self.change_order
        puts 'Would you like to Add or Remove a pizza? -- enter ADD or REMOVE'
        Helper.add_remove_helper(Cli.add_pizza, Cli.remove_pizza)
    end 
    
    def self.create_order
        puts 'You have selected "Create an order"'
        user = Helper.fetch_user
        number = Helper.num_pizzas
        toppings = Helper.what_toppings(number)
        pizza = self.create_pizza(toppings)
        order = Order.new(user_id: user.id, pizza_id: pizza.id)
        puts "You have added #{number} pizza#{Helper.plural(number)} with #{Helper.topping_to_s(toppings)} to your order"
        Cli.end
    end

    def self.no_order
        puts 'You have selected "No existing order"'
        puts 'Would you like to create an order? -- enter (Y/N)'
        answer = self.gets_anwser
        Helper.gets_anwser(Cli.create_order, Cli.end)
    end

    def self.do_you_have_an_order
        puts 'Do you have an existing order? -- enter (Y/N)'
        Helper.gets_anwser(Cli.has_order, Cli.no_order)
    end

    def self.has_order
        puts 'You have selected "Existing order"'
        user = Helper.fetch_user
        puts 'Looking up your order'
        order = Order.find_by(user_id: user.id)
        Cli.found_order(order)
    end

    def self.found_order(order)
        puts 'We found your order: ' #display order information
        puts 'Would you like to make any changes? -- enter (Y/N)'
        Helper.gets_anwser(Cli.change_order, Cli.end)

    end

    def self.lost_order(name)
        puts "I'm sorry, we are unable to locate an order for #{name}."
        puts 'Would you like to place a new order? -- enter (Y/N)'
        Helper.gets_anwser(Cli.create_order, Cli.end)
    end


end