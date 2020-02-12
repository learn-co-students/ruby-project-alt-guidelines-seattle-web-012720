class Ghost < ActiveRecord::Base
    has_many :spooks
    has_many :residents, through: :spooks
    belongs_to :locations

    def attack
        # if 
        #     Spook.new()
        # end
    end

end