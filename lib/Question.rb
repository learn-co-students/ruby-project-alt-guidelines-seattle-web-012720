class Question < ActiveRecord::Base
    has_many :players_questions, :dependent => :delete_all
    has_many :players, through: :players_questions
  end