require_relative '../config/environment'

Question.delete_all
Question.reset_pk_sequence

# emma = Player.create(name: "Emma")
# carol = Player.create(name: "Carol")
# jenny = Player.create(name: "Jenny")


def get_questions_hash_for_category(category_number)
    url = "https://opentdb.com/api.php?amount=25&category=#{category_number}&type=multiple"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    questions = JSON.parse(response.body)
    questions[:category_num] = category_number
    questions
end

def get_art_questions_hash
    url = "https://opentdb.com/api.php?amount=7&category=25&difficulty=medium&type=multiple"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    questions = JSON.parse(response.body)
    questions[:category_num] = 25
    questions
end

def parse_questions_hash(questions_hash)
    @cat = questions_hash[:category_num]
    questions_hash["results"].each do |i|
        i["incorrect_answers"] << i["correct_answer"]
        answers = i["incorrect_answers"]
        fixed_answers = answers.map {|answer|
            answer = answer.gsub("&quot;", "'")
            answer = answer.gsub("&#039;", "'")}
        @question = i["question"].gsub("&quot;", "'")
        @question = @question.gsub("&#039;", "'")
        @choices = fixed_answers.shuffle
        @correct = i["correct_answer"]
        Question.create(question: @question, category_num: @cat, choices: @choices, correct_answer: @correct)
    end
end

def seed_questions_db
    categories = [10, 11, 17, 20, 21, 22, 23, 26, 27]
    categories.each do |num|
        q_hash = get_questions_hash_for_category(num)
        parse_questions_hash(q_hash)
    end
    art_qs = get_art_questions_hash
    parse_questions_hash(art_qs)
    Question.all
end

seed_questions_db