class Beer < ActiveRecord::Base

    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def average_rating
        # sum = 0
        # ratings.each do |rating|
            # sum = sum + rating.score
        # end
        # average = sum / ratings.count
        # return "Has " + ratings.count.to_s + " ratings, average " + average.to_s
        ratings.average :score
    end

    def to_s
        "#{name} #{brewery.name}"
    end
end
