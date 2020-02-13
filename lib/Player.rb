class Player < ActiveRecord::Base
    has_many :players_questions, :dependent => :delete_all
    has_many :questions, through: :players_questions
end