class Brewery < ActiveRecord::Base

    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    def print_report
        puts name
        puts "Established at year #{year}"
        puts "Numer of beers #{beers.count}"
    end

    def restart
        self.year = 2015
        puts "Changed year to #{year}"
    end

    def average_rating
        ratings.average :score
    end

end
