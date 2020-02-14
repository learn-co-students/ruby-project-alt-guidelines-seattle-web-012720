
class CommandLineInterface
    def get_user_input
        gets.chomp.downcase
    end

    def show_logo
      puts ''
      puts " ____________________________________________________".bold
      puts " ____________________________________________________".bold
       puts "     ______           __            __        ".bold
       puts "    /_  __/  _____   / /  _   __   / /  ____ _ ".bold
       puts "     / /    / ___/  / /  | | / /  / /  / __ `/ ".bold
       puts "    / /    / /     /_/   | |/ /  /_/  / /_/ /  ".bold
       puts "   /_/    /_/     (_)    |___/  (_)   \__,_/   ".bold
       puts ""
       puts "___________________________________________________".bold
       puts "___________________________________________________".bold
       puts " "
    end

    def start_screen
        self.show_logo
         puts ""
         puts "        Welcome to Tree-va Time!".bold
         puts ''
         puts "__________________________________________________".bold
         puts " "
         puts ''
     end
     
     def main_menu_options
         system("cls") || system("clear")
         self.show_logo
          puts ''
          puts "-----------------------------------------"
         puts "  Available Search Options"
         puts "-----------------------------------------"
         puts " [1] Create Player and Start New Game"
         puts ''
         puts " [2] Log in to Continue Old Game"
         puts ''
         puts " [3] Exit :("
         puts ''
         puts ''
         puts " Enter your selection:"
         input = get_user_input
         if input == "1"
            self.create_player
           
         elsif input == '2'
            self.enter_user
           
         elsif input == '3'
          puts 'Goodbye!'
          puts ''
           exit
         
         else
           puts "Invalid entry, please press enter to try again."
           gets
         end
         return self.main_menu_options
     end

    def enter_user
      puts ''
      prompt = TTY::Prompt.new
      user_name = prompt.ask("Welcome back! Please enter your Player Name:")
      self.log_in(user_name)
    end

    def greet
      puts "The only true wisdom is in knowing you know nothing."
      puts ''
      puts ''
      puts ''
      puts "           Thanks, Socrates..."
      puts "                 ...but it's still fun to know a lot of random $#!t"
      puts ''
      puts ''
      puts ''
      start = TTY::Prompt.new
      keystroke = start.keypress("Hit ENTER to start.")
        if keystroke
            main_menu_options
        end
    end
  
    def log_in(user_name)
        if Player.find_by(name: user_name)
            @name = user_name
            @player = Player.find_by(name: user_name)
            puts ''
            self.log_in_menu
        else
            prompt = TTY::Prompt.new
            input = prompt.select("Invalid entry. Please try again or return to the main menu.") do |menu|
                menu.choice "Enter your name again.", 1
                menu.choice "Return to the main menu", 2
                end
            if input == 1
                self.enter_user
            elsif input == 2
                self.main_menu_options
            else
                prompt = TTY::Prompt.new
                user = prompt.ask("Invalid entry, please try again.")
                self.log_in(user)
            end
        end
            
    end
    
    def log_in_menu
        system("cls") || system("clear")
         puts ''
         puts "_       __     __                             ____             __  "
         puts "| |     / /__  / /________  ____ ___  ___     / __ )____ ______/ /__"
         puts "| | /| / / _ \\/ / ___/ __ \\/ __ `__ \\/ _ \\   / __  / __ `/ ___/ //_/"
         puts "| |/ |/ /  __/ / /__/ /_/ / / / / / /  __/  / /_/ / /_/ / /__/ ,<   "
         puts "|__/|__/\\___/_/\\___/\\____/_/ /_/ /_/\\___/  /_____/\\__,_/\\___/_/|_|  "
                                                                            
         puts ''
         puts "-----------------------------------------"
        puts " Available Search Options"
        puts "-----------------------------------------"
        puts "[1] Start New Game"
        puts ''
        puts "[2] Continue Game"
        puts ''
        puts "[3] See Your Stats"
        puts ''
        puts "[4] Delete Account"
        puts ''
        puts "[5] Return to Main Menu"
        puts ''
        puts "[6] Exit :("
        puts ''
        puts ''
        puts "Enter your selection:"
        input2 = get_user_input

        if input2 == "1"
          prompt = TTY::Prompt.new
          warn = prompt.yes?("WARNING: This will delete all your stats and prior questions. Are you sure you want to continue? (Type yes/no)") do |q|
            q.default true
            q.positive 'yes'
            q.negative 'no'
          end
          case warn
          when true
            PlayersQuestion.where({player_id: @player.id}).delete_all
            @player.update(clues_available: 3)
            @player.update(correct_counter: 0)
            self.get_question
          when false
            self.log_in_menu
          end
            
        elsif input2 == '2'
            @counter = PlayersQuestion.where({player_id: @player.id}).length
            self.challenge

        elsif input2 == '3'
            q_attempted = PlayersQuestion.where({player_id: @player.id})
            calculate_stats(q_attempted)
            
        elsif input2 == '4'
            puts "WARNING: This will delete EVERY record of you and the games you've played previously. Are you sure you want to continue? (Type yes/no)"
            answer = get_user_input.downcase
                if answer == "yes"
                    PlayersQuestion.where(player_id: @player.id).destroy_all
                    Player.where(id: @player.id).destroy_all
                    self.main_menu_options
                    return
                elsif answer == 'no'
                    log_in_menu
                end
    
        elsif input2 == '5'
            self.main_menu_options

        elsif input2 == '6'
          puts 'Goodbye!'
          puts ''
          return exit

        else
            puts "Invalid entry, please press enter to try again."
            self.log_in_menu
        end
        neext = TTY::Prompt.new
        keystroke = neext.keypress("Hit ENTER to return to your home page.", keys: [:return])
        if keystroke
            self.log_in_menu
        end
    end
    
    
    def create_player
      system("cls") || system("clear") 
      puts ''
      prompt = TTY::Prompt.new
      @name = prompt.ask("First: What is your name?", default: ENV["Player1"])
      puts ''
      puts ''
      self.check_player_name(@name)
    end

    def check_player_name(entered_name)
      if Player.where(name: entered_name).length == 0
        puts "So #{entered_name.capitalize}, you think you know ALL the things... Let's see what you've got!"
        @player = Player.create(name: entered_name, clues_available: 3)
        @counter = 1
        system("cls") || system("clear")
      else
        prompt = TTY::Prompt.new
        input = prompt.select("Sorry, that name has already been claimed. What would you like to do?") do |menu|
            menu.choice "Enter a different name.", 1
            menu.choice "Return to the main menu", 2
        end
        if input ==1
            @name = prompt.ask("Enter a new name:")
            self.check_player_name(@name)
        elsif input == 2
            self.main_menu_options
        else
            puts "Invalid input. Please try again."
            self.check_player_name(@name)
        end
      end
      self.challenge
    end

    def challenge
        puts ''
        puts ''
        puts "So #{@name.capitalize}, you think you know ALL the things... Let's see what you've got!"
        self.get_question
    end

    def select_category
        puts ''
        puts '------------------------------------------------'
        puts "SELECT QUESTION CATEGORY"
        puts '------------------------------------------------'
        puts ''
        puts ''
        require "tty-prompt"
        prompt = TTY::Prompt.new
        @choice = prompt.select("Pick your poison: Select the category from which you'd like to answer a question: (Use ↑/↓ arrow or number (1-10) keys, press Enter to select.)
        
        ", per_page: 10, cycle:true) do |menu|
          menu.enum "."

          menu.choice "Books"
          menu.choice "Films"
          menu.choice "Science"
          menu.choice "Mythology"
          menu.choice "Sports"
          menu.choice "Geography"
          menu.choice "History"
          menu.choice "Art"
          menu.choice "Celebrities"
          menu.choice "Animals"
        end
        puts ''
        puts ''
        command = prompt.yes?("You've chosen #{@choice}. Ready? (Type your answer:)") do |q|
            q.default true
            q.positive 'yes'
            q.negative 'no'
          end
        case command
        when true
          @choice
        when false
          self.get_question
        end
        puts ''
      end

      def read_question
        @q = @new_question.question
        @q = @q.gsub('&amp;', "&")
        # @q = @q.gsub(/[^a-zA-Z0-9?|\s*]/, '')
        choice_string = @new_question.choices
        change_choice_string_to_array(choice_string)
        puts ''
        prompt = TTY::Prompt.new
        @final_choice = prompt.select(@q) do |menu|
            menu.enum "."
            puts ''
          menu.choice @choices[0]
          menu.choice @choices[1]
          menu.choice @choices[2]
          menu.choice @choices[3]
          menu.choice 'Heeelp. Make this easier, please.', "e"
        end
        if @final_choice == "e"
            use_clue(@player)
        end
        self.confirm_submit_answer
        
      end

      def get_question
        category = self.select_category
        system("cls") || system("clear")
        self.show_logo
         puts ''
        puts '_________________________________________________'
        puts "Here we go. As you requested, a question about #{@choice}."
        puts '_________________________________________________'
        puts ''
        category_num = { "Books": 10, "Science": 17, "Films": 11, "Mythology": 20, "Sports": 21, "Geography": 22, "History": 23, "Art": 25, "Celebrities": 26, "Animals": 27 }
        x = category_num[:"#{@choice}"]
        options = Question.where(category_num: x)
        @new_question = options.sample
        self.associate_player_and_question(@new_question)
        self.read_question

      end

      def associate_player_and_question(question)
        PlayersQuestion.create({player_id: @player.id, question_id: question.id})
      end

      def use_clue(player)
        if !player.clues_available
            puts "Sorry, you used all your hints."
              self.read_question
        else
            new_clues = @player.clues_available - 1
            @player.update(clues_available: new_clues)
            puts "You've chosen to get a hint. One answer will be eliminated. You have #{new_clues} clues left."
        end
        choices_string_to_shorten = @new_question.choices
        @choices = change_choice_string_to_array(choices_string_to_shorten)
        if @choices.last != @new_question.correct_answer
            @choices.pop 
        else
            @choices.shift
        end
        prompt = TTY::Prompt.new
        @final_choice = prompt.select(@q) do |menu|
            menu.enum "."
            puts ''
            menu.choice @choices[0]
            menu.choice @choices[1]
            menu.choice @choices[2]
            end
      end

      def confirm_submit_answer
        puts ''
        confirm = TTY::Prompt.new
        next_move = confirm.select("You chose #{@final_choice}. Are you sure?") do |menu|
        puts ''
            menu.enum "."

            menu.choice "I'm sure. The question is, am I RIGHT?!", 2
            menu.choice "WAIT GO BACK I WANT TO CHANGE MY ANSWER!", 1
        end
        case next_move
        when 1
            self.read_question
            # (PlayersQuestion.where(player_id: @player.id).last)
        when 2
            self.submit_answer
        end
      end

      def submit_answer
        to_submit = PlayersQuestion.find_or_create_by(player_id: @player.id, question_id: @new_question.id)
        to_submit.update(chosen_answer: @final_choice)
        self.determine_correct_or_not
      end

      def determine_correct_or_not
        relevant_question_instance = Question.where(id: @new_question.id)
        if relevant_question_instance[0].correct_answer == @final_choice
        puts ''
        puts ''
        puts " $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'              `$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ " 
        puts " $$$$$$$$$$$$$$$$$$$$$$$$$$$$'                   `$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts " $$$'`$$$$$$$$$$$$$'`$$$$$$!                       !$$$$$$'`$$$$$$$$$$$$$'`$$$"
        puts " $$$$  $$$$$$$$$$$  $$$$$$$                         $$$$$$$  $$$$$$$$$$$  $$$$"
        puts " $$$$. `$' \' \$`  $$$$$$$!                         !$$$$$$$  '$/ `/ `$' .$$$$"
        puts " $$$$$. !\  i  i .$$$$$$$$                           $$$$$$$$. i  i  /! .$$$$$"
        puts " $$$$$$   `--`--.$$$$$$$$$                           $$$$$$$$$.--'--'   $$$$$$"
        puts " $$$$$$L        `$$$$$^^$$                           $$^^$$$$$'        J$$$$$$"
        puts " $$$$$$$.   .'   ""~   $$$    $.                 .$  $$$   ~""   `.   .$$$$$$$"
        puts " $$$$$$$$.  ;      .e$$$$$!    $$.             .$$  !$$$$$e,      ;  .$$$$$$$$"
        puts " $$$$$$$$$   `.$$$$$$$$$$$$     $$$.         .$$$   $$$$$$$$$$$$.'   $$$$$$$$$"
        puts " $$$$$$$$    .$$$$$$$$$$$$$!     $$`$$$$$$$$'$$    !$$$$$$$$$$$$$.    $$$$$$$$"
        puts " $JT&yd$     $$$$$$$$$$$$$$$$.    $    $$    $   .$$$$$$$$$$$$$$$$     $by&TL$"
        puts "                                  $    $$    $"
        puts "                                  $.   $$   .$"
        puts "                                  `$        $'"
        puts "                                   `$$$$$$$$'"
        puts "             "
        puts "BOOM, nicely done. You know your #{@choice}!"
            puts ''
            puts ''
            x=0
            @player.update(correct_counter: x+1)
            x = x+1
        else
            puts ""
            puts "                          oooo$$$$$$$$$$$$oooo"
            puts "                       oo$$$$$$$$$$$$$$$$$$$$$$$$o"
            puts "                    oo$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o         o$   $$ o"
            puts "   o $ oo        o$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o       $$ $$ $$o$"
            puts " oo $ $ '$      o$$$$$$$$$    $$$$$$$$$$$$$    $$$$$$$$$o       $$$o$$o$"
            puts " '$$$$$$o$     o$$$$$$$$$      $$$$$$$$$$$      $$$$$$$$$$o    $$$$$$$$'"
            puts "   $$$$$$$    $$$$$$$$$$$      $$$$$$$$$$$      $$$$$$$$$$$$$$$$$$$$$$$"
            puts "   $$$$$$$$$$$$$$$$$$$$$$$    $$$$$$$$$$$$$    $$$$$$$$$$$$$$  \"\"\"$$$"
            puts "    \"$$$\"\"\"\"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$     \"$$$"
            puts "    o$$\"   $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$       $$$o"
            puts "    $$$    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ooooo$$$$o"
            puts "   o$$$oooo$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o$$$$$$$$$$$$$$$$$\""
            puts "   $$$$$$$$\"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$\"\"\"\"\"\"\"\""
            puts "         $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$o$$$\""
            puts "            \"$$$o$$$$$$$$$$$$$$o$$        \"o$$$$$$$$$$$$$$$$$$"
            puts "              $$$$$$$$$$$$$$$$                $$$$$$$$$$$$$$"
            puts "               $$$$$$$$$$$$                       $$$$$$$"
            puts "                \"$$$$o$$$$                        $o$$$$"
            puts "                  \"$$$$$oooo     \"$$$$$$o$$$o\"\"  o$$$\"\""  
            puts "                     \"\"$$$$$oooo-'\"$$$o$$$$$$$$$\"\"\""
            puts "                        \"\"$$$$$$$oo $$$$$$$$$$"       
            puts "                                \"\"\"\"$$$$$$$$$$$"        
            puts "                                    $$$$$$$$$$$$"       
            puts "                                     $$$$$$$$$$\""      
            puts "                                      \"$$$\"\"\"\""
            puts ''
            puts''
            puts "Womp, womp. Nope. The correct answer was #{relevant_question_instance[0].correct_answer}."
            puts ''
            puts ''
        end
        @counter = @counter + 1
        neeext = TTY::Prompt.new
        keystroke = neeext.keypress("Hit ENTER or SPACE to continue.", keys: [:space, :return])
        if keystroke
            self.break
        end
      end

      def break
        system("cls") || system("clear")
        puts ''
        puts '-------------------------------------------------------------'
        puts ''
        prompt = TTY::Prompt.new
        next_move = prompt.select("Whew. #{@counter} down. What's your next move?") do |menu|
          menu.enum "."

          menu.choice "I'm in a groove. Give me another question.", 1
          menu.choice "Brain hurts. Just tell me my score.", 2
        end
        self.run(next_move)
      end
    

      def calculate_stats(q_attempted)
        dividend = q_attempted.length
        puts "Number of Questions Attempted:  #{dividend}"
        divisor = 0
        q_attempted.each do |player_question|
          relevant_question_instance = Question.find(player_question.question_id)
          if player_question.chosen_answer == relevant_question_instance.correct_answer
              divisor += 1
              @player.update(correct_counter: divisor)
          end
        end
        system('cls') || system('clear')
        puts '' 
        puts '--------------------------------------------------'
        puts 'YOUR STATISTICS'
        puts '--------------------------------------------------'
        puts ''
        puts "Number Correct:  #{divisor}"
        puts ''
        puts "Number Incorrect: #{dividend - divisor}"
        puts ''
        puts "Clues Used:  #{3 - @player.clues_available}"
        puts ''
        score = 100 * divisor/dividend.to_f
        puts "Overall Score:  #{score.round(2)}%"
        puts ''
        puts "Judgment of you as a person:"
          if score < 55
              puts "  Oof. Study up."
          elsif score < 85
              puts "  All right, all right, I see you. Nicely done."
          elsif score >= 85
              puts "  I salute you, professor! You are indeed a trivia master!"
          else
            puts "Error"
          end
        puts '' 
        puts ''
        puts "If you would like to see a list of all the questions you've answered, press '1'.

        Otherwise, hit ENTER."
        see_questions = get_user_input
        if see_questions == "1"
          i = 1
          @player.questions.each do |instance|
            puts "   #{i}. #{instance.question}"
            i +=1
          end
        elsif see_questions == :enter
        end
        puts ''
         
        self.end_game?
      end

    def end_game?
      puts ''
        ending = TTY::Prompt.new
        x = ending.select("Hit ENTER to return to the main menu, or use the menu below to select a different option.") do |menu|
            menu.enum "."

            menu.choice "Logout and return to main menu", 1
            menu.choice "Return to my own home page", 2
            menu.choice "Exit.", 3
        end
        if x == 1
            self.main_menu_options
        elsif x == 2
            log_in_menu
        elsif x == 3
            puts 'Goodbye!'
            puts ''
            exit
        else
            puts "Invalid input. Please try again."
            self.end_game
        end
      end


      def run(next_move)
        case next_move
        when 1
          self.get_question
        when 2
          questions_answered = PlayersQuestion.where(player_id: @player.id)
          calculate_stats(questions_answered)
        end
      end


      def change_choice_string_to_array(choice_string)
        array = choice_string.split(",")
        @choices = array.map {|choice|
            choice = choice.gsub("&#039", "'");  
            choice = choice.gsub('&amp;', "&")
            choice = choice.gsub('&quot;', "'")
            # choice.gsub!(/[^a-zA-Z0-9.?-\/|\s*]/, '')
            choice = choice.strip} 
      end

      def end_game
        Question.destroy_by
        PlayersQuestion.destroy_by
      end


end