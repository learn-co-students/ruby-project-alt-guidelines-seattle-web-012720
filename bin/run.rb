require_relative '../config/environment'
require "tty-prompt"
require "pry"

prompt = TTY::Prompt.new


cli = CommandLineInterface.new

cli.menu_selection
#user enters a choice  

