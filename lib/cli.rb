class Cli

    ### initialize function
    def run
        puts "\n\nWelcome to Sliceline, the best way to order pizza!\n\n"
        Cli.do_you_have_an_order
    end

    ### terminate function
    def self.goodbye
        puts "\nThanks for using Sliceline!\n\n"
    end

    def self.end 
        puts "Is there anything else we can help you with? -- enter (Y/N)\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.do_you_have_an_order
        elsif answer == false 
            Cli.goodbye
        end 
    end

    ### pizza functions
    def self.remove_pizza(order)
        puts "How many pizzas would you like to remove? -- enter a number\n\n"
        number = Helper.remove_pizza(order)
        puts "You have removed #{number} pizza#{Helper.plural(number)}.\n"
        number = order.num_pizzas
        value1 = Helper.plural(number)
        value2 = Helper.topping_to_s(order.pizzas.first.toppings)
        if number == 0
            puts "\nYou have nothing in your order."
        else
            puts "\nYour order is now: #{number} pizza#{value1} with #{value2}"
        end
        puts "\nWould you like to make any other changes to your order? -- enter (Y/N)\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.modify_order(order)
        elsif answer == false 
            Cli.end
        end 
    end

    def self.add_pizza(order)
        puts 'You have selected "ADD a pizza"'
        puts "\nEnter the number of pizzas you would like to add\n\n"
        number = Helper.gets_number
        order.num_pizzas += number
        Cli.end
    end

    ### order functions

    def self.change_items_in_order(order)
        puts "You have selected change items in your order"
        answer = Helper.comparison_helper('add', 'remove', ' pizza')
        if answer == true
            Cli.add_pizza(order)
        elsif answer == false 
            Cli.remove_pizza(order)
        end 
    end 
    
    def self.cancel(order)
        puts "\nYou have selected cancel order"
        puts "\nDo you wish to proceed with cancelling your order? -- enter (Y/N)"
        answer = Helper.gets_answer
        if answer == true
            Helper.delete_order(order)
        end
        Cli.end
    end 
    
    def self.modify_order(order)
        puts "You have selected modify order"
        answer = Helper.comparison_helper('change', 'cancel', 'n order')
        if answer == true
            Cli.change_items_in_order(order)
        elsif answer == false 
            Cli.cancel(order)
        end 

    end

    def self.found_order(order)
        number = order.num_pizzas 
        value1 = Helper.plural(number)
        value2 = Helper.topping_to_s(order.pizzas.first.toppings)
        puts "\nWe found your order: #{number} pizza#{value1} with \n#{value2}."
        puts "\nWould you like to modify it? -- enter (Y/N)\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.modify_order(order)
        elsif answer == false 
            Cli.end
        end 
    end
    
    def self.create_pizza(user) 
        number = Helper.num_pizzas
        toppings = Helper.what_toppings(number)
        pizza = Helper.create_pizza(toppings)
        order = Order.create(user_id: user.id, num_pizzas: number)
        order.pizzas << pizza
        value1 = Helper.plural(number)
        value2 = Helper.topping_to_s(toppings)
        puts "\nYou have added #{number} pizza#{value1} with \n#{value2} to your order\n\n"
        Cli.end
    end

    def self.lost_order(user)
        puts "\nI'm sorry, we are unable to locate an order for #{user.name}."
        puts "\nWould you like to place a new order? -- enter (Y/N)\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.create_pizza(user)
        elsif answer == false 
            Cli.end
        end 
    end

    def self.has_order
        puts "You have selected Existing order\n"
        user = Helper.fetch_user
        puts "\nLooking up your order..."
        order = Order.find_by(user_id: user.id)
        if order == nil
            Cli.lost_order(user)
        else
            Cli.found_order(order)
        end
    end

    def self.create_order
        puts 'You have selected "Create an order"'
        user = Helper.fetch_user
        Cli.create_pizza(user)
    end

    def self.no_order
        puts "You have selected No existing order"
        puts "\nWould you like to create an order? -- enter (Y/N)\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.create_order
        elsif answer == false 
            Cli.end
        end 
    end

    def self.do_you_have_an_order
        puts "Do you have an existing order? -- enter (Y/N)\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.has_order
        elsif answer == false 
            Cli.no_order
        end 
    end
end