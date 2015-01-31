class Beer < ActiveRecord::Base

    include RatingAverage

    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    validates :name, presence: true

    #def average_rating
        ## sum = 0
        ## ratings.each do |rating|
            ## sum = sum + rating.score
        ## end
        ## average = sum / ratings.count
        ## return "Has " + ratings.count.to_s + " ratings, average " + average.to_s
        #ratings.average :score
    #end
    
    def average
        return 0 if ratings.empty?
        ratings.map{ |r| r.score }.sum / ratings.count.to_f
    end

    def to_s
        "#{name} #{brewery.name}"
    end
end
