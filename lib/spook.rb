class Spook <ActiveRecord::Base
    belongs_to :ghosts
    belongs_to :residents

    def spook
        if Location.residents_in_room

        end
    end

end