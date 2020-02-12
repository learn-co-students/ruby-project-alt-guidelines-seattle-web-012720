$counter = 1
class CommandLineInterface
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
            self.create_player
        end
    end
  
    def create_player
      system("cls") || system("clear") 
      prompt = TTY::Prompt.new
      @name = prompt.ask("First: What is your name?", default: ENV["Player1"])
      puts ''
      puts ''
      puts "So #{@name.capitalize}, you think you know ALL the things... Let's see what you've got!"
      @player = Player.create(name: @name, clues_available: 3)
      system("cls") || system("clear")
    end

    def challenge
        puts ''
        puts ''
        puts "So #{@name.capitalize}, you think you know ALL the things... Let's see what you've got!"
    end

    def select_category
        puts ''
        puts ''
        puts '------------------------------------------------'
        puts "SELECT QUESTION CATEGORY"
        puts '------------------------------------------------'
        puts ''
        puts ''
        require "tty-prompt"
        prompt = TTY::Prompt.new
        @choice = prompt.select("Pick your poison: Select the category from which you'd like to answer a question: (Use ↑/↓ arrow or number (1-10) keys, press Enter to select.)
        
        ", per_page: 10) do |menu|
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
          select_category
        end
        puts ''
      end

      def read_question
        @q = @new_question.question.gsub!("&quot;", "'").gsub!("&#039;", "'")
        choice_string = @new_question.choices
        change_choice_string_to_array(choice_string)
        prompt = TTY::Prompt.new
        @final_choice = prompt.select(@q) do |menu|
            menu.enum "."
          menu.choice @choices[0].gsub!("&quot;", "'").gsub!("&#039;", "'")
          menu.choice @choices[1].gsub!("&quot;", "'").gsub!("&#039;", "'")
          menu.choice @choices[2].gsub!("&quot;", "'").gsub!("&#039;", "'")
          menu.choice @choices[3].gsub!("&quot;", "'").gsub!("&#039;", "'")
          menu.choice 'Heeelp. Make this easier, please.', "e"
        end.gsub!("&quot;", "'").gsub!("&#039;", "'")
        # if @final_choice == "e"
        #     use_clue(@player)
        # end
        self.confirm_submit_answer
        
      end

      def get_question
        category = self.select_category
        puts ''
        puts "Here we go. As you requested, a question about #{@choice}."
        puts '_________________________________________________'
        category_num = { "Books": 10, "Science": 17, "Films": 11, "Mythology": 20, "Sports": 21, "Geography": 22, "History": 23, "Art": 25, "Celebrities": 26, "Animals": 27 }
        x = category_num[:"#{@choice}"]
        options = Question.where(category_num: x)
        @new_question = options.sample
        binding.pry
        self.associate_player_and_question
        @new_question
      end

      def associate_player_and_question
        binding.pry
        Players_Question.create(player_id: @player.id, question_id: @new_question.id)
        # options.reject { |i| i == @new_question.id }
        # read_question
      end

    #   def use_clue(player)
    #     if player.clues_available == 0
    #         puts "Sorry, you used all your hints."
    #         choice = prompt.select(@q) do |menu|
    #             menu.enum "."
    #             menu.choice @choices[0]
    #             menu.choice @choices[1]
    #             menu.choice @choices[2]
    #             menu.choice @choices[3]
    #         end
    #     else
    #         new_clues = @player.clues_available - 1
    #         @player.update(clues_available: new_clues)
    #         puts "You've chosen to get a hint. One answer will be eliminated. You have #{new_clues} clues left."
    #         ##eliminate answer and reprint options

    #         to_edit = Question.find_by(id: @new_question.id)
    #         choices_string_to_shorten = to_edit.choices
    #         @choices = change_choice_string_to_array(choices_string_to_shorten)
    #         @choices.pop if @choices.last != to_edit.correct_answer
    #         to_edit.choices.shift
    #         choice = prompt.select(@q) do |menu|
    #             menu.enum "."
    #             menu.choice @choices[0]
    #             menu.choice @choices[1]
    #             menu.choice @choices[2]
    #         end
    #     end
    #   end

      def confirm_submit_answer
        confirm = TTY::Prompt.new
        next_move = confirm.select("You chose #{@final_choice}. Are you sure?") do |menu|
            menu.enum "."

            menu.choice "I'm sure. The question is, am I RIGHT?!", 2
            menu.choice "WAIT GO BACK I WANT TO CHANGE MY ANSWER!", 1
        end
        case next_move
        when 1
            self.read_question
            # (Players_Question.where(player_id: @player.id).last)
        when 2
            self.submit_answer
        end
      end

      def submit_answer
        binding.pry
        to_submit = Players_Question.find_by(player_id: @player.id, question_id: @new_question.id)
        to_submit.update(chosen_answer: @final_choice)
        self.determine_correct_or_not
      end

      def determine_correct_or_not
        relevant_question_instance = Question.find(id: @new_question.id)
        if relevant_question_instance.correct_answer == @final_choice
            puts "Boom, nicely done. You know your #{category}!"
            puts ''
            puts ''
        else
            puts "Womp, womp. Nope. The correct answer was #{relevant_question_instance.correct_answer}."
            puts ''
            puts ''
            puts ''
        end
        $counter += 1
      end

      def break
        prompt = TTY::Prompt.new
        next_move = prompt.select("Whew. #{counter} down. What's your next move?") do |menu|
          menu.enum "."

          menu.choice "I'm in a groove. Give me another question.", 1
          menu.choice "Brain hurts. Just tell me my score.", 2
        end
        next_move
      end
    
      def calculate(questions_answered)
        dividend = questions_answered.length
        divisor = 0
        questions_answered.each do |player_question|
          relevant_question_instance = Question.where(id: player_question.question_id)
          if player_question.chosen_answer == relevant_question_instance.correct_answer
            divisor += 1
          end
        end
        score = 100 * ((divisor / dividend).to_f)
        if score < 55
          puts "Oof. Study up."
        elsif score < 85
          puts "All right, all right, I see you. Nicely done."
        else
          puts "I salute you, professor! You are indeed a trivia master!"
        end
        puts "You scored a #{score}%. Good game."
      end


      def run
        next_move = cli.break
        case next_move
        when 1
          self.get_question
        when 2
          #calculate score
          questions_answered = Players_Question.find_by(player_id: @player.id)
          calculate(questions_answered)
        end
      end


      def change_choice_string_to_array(choice_string)
        array = choice_string.split(",")
        @choices = array.map {|choice|
            choice.gsub!(/[^0-9a-z\s]/i, '').strip}
      end

      def end_game
        Question.destroy_all
        Players_Question.destroy_all
      end
end