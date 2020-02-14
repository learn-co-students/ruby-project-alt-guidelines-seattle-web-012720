class Question < ActiveRecord::Base
    has_many :players_questions
    has_many :players, through: :players_questions
  end