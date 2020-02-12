require 'pry'
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
        input = gets.chomp 
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

    def menu_selection 
     greet 
    #  display_main_menu
     display_tea_menu 
     input = gets.chomp 

     case input 
        when input == 1 
            User.create_tea_order(1) 
            display_topping_menu 
        when input == 15 
            User.delete_drink_order
            
        end 
        
    end 


end 

