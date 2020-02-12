require_relative '../config/environment'

class Run
    cli = CommandLineInterface.new

    cli.intro

    while true
        puts "\nType 'help' to see the list of available commands. Type 'quit' to exit.".magenta
        print "Enter command: ".cyan
        input = gets.chomp

        break if input == "quit"

        case input
        when "help"
            cli.help
        when "list rooms"
            Location.list_rooms
        when "list family"
            Resident.list_family
        when "where am I"
            Location.where_am_i
        when input.include?("move to ")
            room = input.split("move to ")
            Resident.move_to(room[1])
        else
            puts "\n  invalid command, type 'help' to see a list of available commands"
        end
    end
end