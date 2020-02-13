class Cli
    @@y = "Y".colorize(:red)
    @@n = "N".colorize(:red)
    @@b1 = "- enter - ".colorize(:blue) 
    @@b2 = " or ".colorize(:blue) 
    @@str = "#{@@b1}#{@@y}#{@@b2}#{@@n}"

    ### initialize function
    def run
        str = "Sliceline".colorize(:red)
        puts "\n\nWelcome to #{str}, the best way to order pizza!\n\n"
        Cli.do_you_have_an_order
    end

    ### terminate function
    def self.goodbye
        str = "Sliceline".colorize(:red)
        puts "\nThanks for using #{str}!\n\n"
    end

    def self.end 
        puts "Is there anything else we can help you with? #{@@str}\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.do_you_have_an_order
        elsif answer == false 
            Cli.goodbye
        end 
    end

    ### pizza functions
    def self.remove_pizza(order)
        str1 = "remove".colorize(:red)
        str2 = "number".colorize(:red)
        puts "You have selected #{str1} a pizza"
        puts "\nEnter the #{str2} of pizzas you would like to remove\n\n"
        number = Helper.remove_pizza(order)
        value1 = number.to_s.colorize(:red)
        value2 = Helper.plural(number)
        puts "You have removed #{value1} pizza#{value2}.\n"
        number = Helper.display_order(order)
        puts "\nWould you like to make any other changes to your order? #{@@str}\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.modify_order(order)
        elsif answer == false 
            Cli.end
        end 
    end

    def self.add_pizza(order)
        str1 = "ADD".colorize(:red)
        str2 = "number".colorize(:red)
        puts "You have selected #{str1} a pizza"
        puts "\nEnter the #{str2} of pizzas you would like to add\n\n"
        number = Helper.gets_number
        order.num_pizzas += number
        order.save
        puts "You have added #{number.to_s.colorize(:red)} pizzas to your order\n\n"
        Helper.display_order(order)
        Cli.end
    end

    ### order functions

    def self.change_items_in_order(order)
        str = "change".colorize(:red)
        puts "You have selected #{str} items in your order"
        answer = Helper.comparison_helper('add', 'remove', ' pizza')
        if answer == true
            Cli.add_pizza(order)
        elsif answer == false 
            Cli.remove_pizza(order)
        end 
    end 
    
    def self.cancel(order)
        str = "cancel".colorize(:red)
        puts "\nYou have selected #{str} order"
        puts "\nDo you wish to proceed with cancelling your order? #{@@str}"
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
        value1 = number.to_s.colorize(:red)
        value2 = Helper.plural(number)
        value3 = Helper.topping_to_s(order.pizzas.first.toppings)
        puts "\nWe found your order: #{value1} pizza#{value2} with \n#{value3}."
        puts "\nWould you like to modify it? #{@@str}\n\n"
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
        topping_objects = Topping.all.select {|topping| toppings.include?(topping.name)}
        value1 = number.to_s.colorize(:red)
        value2 = Helper.plural(number)
        value3 = Helper.topping_to_s(topping_objects)
        puts "\nYou have added #{value1} pizza#{value2} with \n#{value3} to your order\n\n"
        Cli.end
    end

    def self.lost_order(user)
        puts "\nI'm sorry, we are unable to locate an order for #{user.name}."
        puts "\nWould you like to place a new order? #{@@str}\n\n"
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
        puts "\nWould you like to create an order? #{@@str}\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.create_order
        elsif answer == false 
            Cli.end
        end 
    end

    def self.do_you_have_an_order
        puts "Do you have an existing order? #{@@str}\n\n"
        answer = Helper.gets_answer
        if answer == true
            Cli.has_order
        elsif answer == false 
            Cli.no_order
        end 
    end
end