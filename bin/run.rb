require_relative '../config/environment'


cli = CommandLineInterface.new
# main_menu
# cli.greet


# cli.challenge
cli.get_question
cli.read_question

cli.break
cli.run

# CLEANING
# &quot; -- replace with '
# &#039;s -- replace with '

# def clean(hash)
#     hash.values.each {|value|
#         value.gsub!("&quot;", "'").gsub!("&#039;", "'")}
# end