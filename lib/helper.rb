class Helper

    def self.plural(number)
        if number > 1
            "s"
        else 
            ""
        end
    end

    def self.gets_answer(yesfunction, nofunction)
        a = gets.chomp
        if a != "Y" || a != "y" || a != "N" || a != "n"
            until a == a != "Y" || a != "y" || a != "N" || a != "n"
                puts 'Please enter Y or N'
                a = gets.chomp 
            end 
        end
        if a == "Y" || a == "y"
            yesfunction
        elsif a == "N" || a == "n"
            nofunction
        end
    end

    def self.gets_number
        number = gets.chomp 
        if !number.i || number < 0
            until number.i 
                puts 'Please enter a number greater than zero'
                number = gets.chomp 
            end 
        end 
        number 
    end

    def self.num_pizzas
        puts 'How many pizzas would you like? -- enter a number'
        Helper.gets_number
    end

    def self.remove_pizza(order)
        number = Helper.gets_number
        if order.num_pizzas >= number
            order.num_pizzas -= number
        else 
            until number <= order.num_pizzas 
                puts "Your order only has #{number} pizza#{Helper.plural(number)}."
                puts "How many would you like to remove?"
                number = Helper.gets_number 
            end
            order.num_pizzas -= number
        end
        number
    end

    def self.fetch_user
        puts 'What is your name?'
        name = gets.chomp
        user = User.find_by(name: name)
        if user.empty?
            user = User.create(name: name)
        puts "Hello #{user.name}"
        user
    end

    def self.topping_to_s(toppings)
        index = 0
        topping_name = ""
        toppings.length.times do 
            if index == toppings.length - 1
                topping_name.concat(" and #{toppings[index]}.")
            else 
                topping_name.concat("#{toppings[index]}, ")
            end
        end
        topping_name
    end

    def self.what_toppings(number)
        puts "What toppings would you like on your #{number} pizza#{Helper.plural(number)}?"
        answer = gets.chomp
        toppings = answer.split(/, |, and| and | /).sort()
        toppings.each {|topping| 
            Topping.create(name: topping) if Topping.find_by(name: topping).empty?
        }
        toppings
    end

    def self.create_pizza(toppings)
        pizza = Pizza.all.select {|pizza| pizza.toppings == toppings}
        if pizza.empty?
            name = "A pizza with #{self.topping_to_s(toppings)}"
            pizza = Pizza.create(name: name)
        end
        pizza.pizza_topping_helper(toppings)
        pizza 
    end

    def self.add_remove_helper(yesfunction, nofunction)
        puts 'Would you like to Add or Remove a pizza? -- enter ADD or REMOVE'
        a = gets.chomp
        if a != "ADD" || a != "add" || a != "REMOVE" || a != "remove"
            until a != "ADD" || a != "add" || a != "REMOVE" || a != "remove"
                puts 'Please enter ADD or REMOVE'
                a = gets.chomp 
            end 
        end
        if a != "ADD" || a != "add"
            yesfunction
        elsif a != "REMOVE" || a != "remove"
            nofunction
        end
    end 

    def self.print

    end
end