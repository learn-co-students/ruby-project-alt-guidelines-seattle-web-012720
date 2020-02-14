class Player < ActiveRecord::Base
    has_many :players_questions
    has_many :questions, through: :players_questions
end