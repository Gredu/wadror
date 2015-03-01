class BeerClub < ActiveRecord::Base

    has_many :membership

    def to_s
        self.name
    end

end
