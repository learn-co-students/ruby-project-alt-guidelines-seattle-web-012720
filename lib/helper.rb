class Helper

    def self.plural(number)
        if number > 1
            "s"
        else 
            ""
        end
    end

        ###took function from https://stackoverflow.com/questions/39743299/check-if-a-string-contains-only-digits-in-ruby
    def self.check_string(string)
        result = true
        if string.to_i.to_s.eql? string
          result =  false
        end
        result
      end
        ###

    def self.gets_answer
        a = gets.chomp
        if a.downcase != "y" || a.downcase != "n"
            until a.downcase == "y" || a.downcase == "n"
                puts "\nPlease enter Y or N\n\n"
                a = gets.chomp 
            end 
        end
        puts "\n"
        if a.downcase == "y"
            true
        elsif a.downcase == "n"
            false
        end
    end

    def self.gets_number
        number = gets.chomp
        if Helper.check_string(number)
            until !Helper.check_string(number)
                puts "\nPlease enter an integer\n\n"
                number = gets.chomp 
            end 
        elsif number.to_i < 0
            until number.to_i > 0
                puts "\nPlease enter a number greater than zero\n\n"
                number = gets.chomp 
            end 
        end 
        puts "\n"
        number.to_i
    end

    def self.num_pizzas
        puts "\nHow many pizzas would you like? -- enter a number\n\n"
        Helper.gets_number
    end

    def self.remove_pizza(order)
        number = Helper.gets_number
        if order.num_pizzas >= number
            order.num_pizzas -= number
        else 
            until number <= order.num_pizzas 
                puts "\nYour order only has #{number} pizza#{Helper.plural(number)}."
                puts "\nHow many would you like to remove?\n\n"
                number = Helper.gets_number 
            end
            order.num_pizzas -= number
        end
        number
    end

    def self.fetch_user
        puts "\nWhat is your name?\n\n"
        name = gets.chomp
        user = User.find_by(name: name)
        if user == nil
            user = User.create(name: name)
        end
        puts "\nHello #{user.name}\n"
        user
    end

    def self.topping_to_s(toppings)
        index = 0
        topping_name = ""
        toppings.length.times do 
            if toppings.length == 1
                topping_name.concat("#{toppings[index].name}")
            elsif index == toppings.length - 1
                topping_name.concat("and #{toppings[index].name}")
            else 
                topping_name.concat("#{toppings[index].name}, ")
            end
            index += 1
        end
        topping_name
    end

    def self.what_toppings(number)
        puts "What toppings would you like on your #{number} pizza#{Helper.plural(number)}?\n\n"
        answer = gets.chomp
        toppings = answer.split(/, and | and |, /).sort()
        toppings.each {|topping| 
            Topping.create(name: topping) if Topping.find_by(name: topping) == nil
        }
        toppings
    end

    def self.create_pizza(toppings)
        pizza = Pizza.all.select {|pizza| pizza.toppings == toppings}
        if pizza.empty?
            name = "A pizza with #{Helper.topping_to_s(toppings)}."
            pizza = Pizza.create(name: name)
        end
        topping_objects = Topping.all.select {|topping| toppings.include?(topping.name)}
        pizza.pizza_topping_helper(topping_objects)
        pizza 
    end

    def self.comparison_helper(str1, str2, str3)
        puts "\nWould you like to #{str1.capitalize} or #{str2.capitalize} a#{str3}? -- enter #{str1.upcase} or #{str2.upcase}\n\n"
        a = gets.chomp
        if a.downcase != str1 || a.downcase != str2
            until a.downcase == str1 || a.downcase == str2
                puts "\nPlease enter #{str1.upcase} or #{str2.upcase}\n\n"
                a = gets.chomp 
            end 
        end
        puts "\n"
        if  a.downcase == str1
            true
        elsif a.downcase == str2
            false
        end
    end 

    def self.delete_order(order)
        Order.destroy(order.id)
        puts "You have successfully deleted your order\n\n"
    end
end