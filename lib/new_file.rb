require 'pry'
require "tty-prompt"
require_relative '../config/environment'


class CommandLineInterface 

    ###############################
    #          GREETINGS          #
    #                             #
    ###############################
    def greet
        puts "Welcome to Boba Tea Shop."
    end 

    ###############################
    #           MENUS             #
    #                             #
    ###############################

    def display_main_menu
        puts "Please select an option"
        puts "1 Order a tea"
        puts "2 View your order"
        puts "3 Cancel your order"
        puts "4 Today's Popular Drink"
        puts "Exit"
    end 
    
    def display_tea_menu
        puts "Please select a tea:"
        puts "1 Green Tea"
        puts "2 Black"
        puts "3 Thai" 
        puts "4 White"
        puts "5 Wintermelon"
    end 

    def display_topping_menu 
        puts "Please select a topping:"
        puts "1 Boba"
        puts "2 Mini"
        puts "3 Popping"
        puts "4 Coffee Jelly"
        puts "5 Grass Jelly"
        puts "7 None" 
    end 

    def order_confirmation 
        puts "1 confirm order"
        puts "2 back to update order"
        puts "3 cancel order"
    end 

    ###############################
    #            MENU             #
    #          Selection          #
    ###############################

      
    def tea_selection(user)
        greet 
       
        prompt = TTY::Prompt.new

        def ask_for_a_name 
            name = prompt.ask('What is your name?')
            prompt = TTY::Prompt.new
            user.name = name 
        end 
  

        input_1 = prompt.select('Please select a type of tea') do |menu|
          puts "----------------"
            menu.choice 'Green Tea', 1
            menu.choice 'Black Tea', 2
            menu.choice 'Thai Tea', 3
            menu.choice 'White Tea', 4
            menu.choice 'Wintermelon', 5
           
        end 

        if input_1 == 1
            user.create_tea_order(1)
        elsif input_1 == 2
            user.create_tea_order(2)
        elsif input_1 == 3
            user.create_tea_order(3)
        elsif input_1 == 4
            user.create_tea_order(4)
        elsif input_1 == 5
            user.create_tea_order(5)
        end 

        prompt = TTY::Prompt.new
        input_2 = prompt.select('Please select a topping') do |menu|
            menu.default 6
            
            menu.choice 'Boba', 1
            menu.choice 'Mini', 2
            menu.choice 'Popping', 3
            menu.choice 'Coffee Jelly', 4
            menu.choice 'Grass Jelly', 5
            menu.choice 'None', 6 
        end 

        if input_2 == 1
            user.create_topping_order(1)
        elsif input_2 == 2
            user.create_topping_order(2)
        elsif input_2 == 3
            user.create_topping_order(3)
        elsif input_2 == 4
            user.create_topping_order(4)
        elsif input_2 == 5
            user.create_topping_order(5)
        elsif input_2 == 6
        end 
    end 


    def order_confirmation(user)
        prompt = TTY::Prompt.new

        input_3 = prompt.select('Please confirm order or select another option') do |menu|
            menu.default 1 
            
            menu.choice 'Confirm order', 1
            menu.choice 'Update Order', 2
            menu.choice 'Cancel Order', 3
        end 

        

        if input_3 == 1
            if user.drink.topping_id != nil
                puts "You ordered #{user.drink.tea.name} with #{user.drink.topping.name}."
                total = user.drink.tea.price + user.drink.topping.price
                puts "Your total comes out to $#{total}0. Thank you for visiting."
            else
                puts "You ordered #{user.drink.tea.name}."
                total = user.drink.tea.price 
                puts "Your total comes out to $#{total}0. Thank you for visiting."
            end 

        elsif input_3 == 2
           tea_selection(user) 
           confirm_w_update
        elsif input_3 == 3
            puts "Your order has been cancelled."
            user.destroy 
        end


    end 

    def confirm_w_update
        order_confirmation(user)
    end 

    
    
    ####CLASS END####
    end 
