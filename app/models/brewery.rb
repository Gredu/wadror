class Brewery < ActiveRecord::Base

    include RatingAverage

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    validates :name, presence: true
    validates :year, numericality: { greater_than_or_equal_to: 1042,
                                    less_than_or_equal_to: -> (_) { Time.now.year },
                                    only_integer: true }

    scope :active, -> { where active: true }
    scope :retired, -> { where active: [nil, false] }

    def print_report
        puts name
        puts "Established at year #{year}"
        puts "Numer of beers #{beers.count}"
    end

    def restart
        self.year = 2015
        puts "Changed year to #{year}"
    end

    def self.top(n)
        sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| -(b.average_rating||0) }.take n
    end
    

    # def average_rating
        # ratings.average :score
    # end

end
