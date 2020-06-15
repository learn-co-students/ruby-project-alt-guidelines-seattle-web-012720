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
        y = "Y".colorize(:red)
        n = "N".colorize(:red)
        str1 = "Please enter ".colorize(:blue)
        str2 = " or ".colorize(:blue)
        a = gets.chomp
        if a.downcase != "y" || a.downcase != "n"
            until a.downcase == "y" || a.downcase == "n"
                puts "\n#{str1}#{y}#{str2}#{n}\n\n"
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
        str1 = "Please enter an ".colorize(:blue)
        str2 = "integer".colorize(:red)
        str3 = "Please enter a ".colorize(:blue)
        str4 = "number".colorize(:red)
        str5 = " greater than zero".colorize(:blue)
        number = gets.chomp
        if Helper.check_string(number)
            until !Helper.check_string(number)
                puts "\n#{str1}#{str2}\n\n"
                number = gets.chomp 
            end 
        elsif number.to_i <= 0
            until number.to_i > 0
                puts "\n#{str3}#{str4}#{str5}\n\n"
                number = gets.chomp 
            end 
        end 
        puts "\n"
        number.to_i
    end

    def self.num_pizzas
        str1 = "- enter - a ".colorize(:blue)
        str2 = "number".colorize(:red)
        puts "\nHow many pizzas would you like? #{str1}#{str2}\n\n"
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
            order.save
        end
        number
    end

    def self.fetch_user
        str = "name".colorize(:magenta)
        puts "\nWhat is your #{str}?\n\n"
        name = gets.chomp.downcase.capitalize
        user = User.find_by(name: name)
        if user == nil
            user = User.create(name: name)
        end
        puts "\nHello #{user.name.colorize(:magenta)}\n"
        user
    end

    def self.topping_to_s(toppings, name= false)
        index = 0
        topping_name = ""
        toppings.length.times do 
            if name == false 
                str = toppings[index].name.colorize(:cyan)
            elsif name == true 
                str = toppings[index].name
            end
            if toppings.length == 1
                topping_name.concat("#{str}")
            end
            if toppings.length > 1
                if index == toppings.length - 1
                    topping_name.concat("and #{str}")
                else 
                    topping_name.concat("#{str}, ")
                end
            end
            index += 1
        end
        topping_name
    end

    def self.what_toppings(number)
        str = "toppings".colorize(:cyan)
        puts "What #{str} would you like on your #{number.to_s.colorize(:red)} pizza#{Helper.plural(number)}?\n\n"
        answer = gets.chomp
        toppings = answer.split(/, and | and |, /).sort().each {
            |topping| topping.downcase.capitalize }
        toppings.each {|topping| 
            Topping.create(name: topping) if Topping.find_by(name: topping) == nil
        }
        toppings
    end

    def self.create_pizza(toppings)
        topping_objects = Topping.all.select {|topping| toppings.include?(topping.name)}
        pizza = Pizza.all.select {|pizza| pizza.toppings == topping_objects}
        if pizza.empty?
            name = "A pizza with #{Helper.topping_to_s(topping_objects, true)}."
            pizza = Pizza.create(name: name)
            pizza.pizza_topping_helper(topping_objects)
        end
        pizza 
    end

    def self.comparison_helper(str1, str2, str3)
        str4 = "- enter - ".colorize(:blue)
        str5 =" or ".colorize(:blue)
        str6 = "#{str4}#{str1.upcase.colorize(:red)}#{str5}#{str2.upcase.colorize(:red)}"
        str7 = "Please enter ".colorize(:blue)
        str8 = " or ".colorize(:blue)
        puts "\nWould you like to #{str1.capitalize} or #{str2.capitalize} a#{str3}? #{str6}\n\n"
        a = gets.chomp
        if a.downcase != str1 || a.downcase != str2
            until a.downcase == str1 || a.downcase == str2
                puts "\n#{str7}#{str1.upcase.colorize(:red)}#{str8}#{str2.upcase.colorize(:red)}\n\n"
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
        str = "cancelled".colorize(:red)
        puts "You have successfully #{str} your order\n\n"
    end

    def self.display_order(order)
        number = order.num_pizzas
        if number == 0
            puts "\nYou have nothing in your order."
        else
            pizza = Pizza.all.select {|pizza| pizza.id == order.pizza_id}.first
            value1 = number.to_s.colorize(:red)
            value2 = Helper.plural(number)
            value3 = Helper.topping_to_s(pizza.toppings)
            puts "\nYour order is now #{value1} pizza#{value2} with \n#{value3}.\n\n"
        end
        number
    end

    def self.add_pizza 
        str1 = "ADD".colorize(:red)
        str2 = "number".colorize(:red)
        puts "You have selected #{str1} a pizza"
        puts "\nEnter the #{str2} of pizzas you would like to add\n\n"
    end
end