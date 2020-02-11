class Resident < ActiveRecord::Base
    has_many :spooks
    has_many :ghosts, through: :spooks
    belongs_to :locations



end