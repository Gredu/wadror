class Beer < ActiveRecord::Base

    include RatingAverage

    belongs_to :brewery
    has_many :ratings, dependent: :destroy
    has_many :raters, -> { uniq }, through: :ratings, source: :user

    validates :name, presence: true
    validates :style, presence: true

    #def average_rating
        ## sum = 0
        ## ratings.each do |rating|
            ## sum = sum + rating.score
        ## end
        ## average = sum / ratings.count
        ## return "Has " + ratings.count.to_s + " ratings, average " + average.to_s
        #ratings.average :score
    #end
    
    def self.top(n)
        sorted_by_rating_in_desc_order = Beer.all.sort_by{ |b| -(b.average_rating||0) }.take n
    end

    def average
        return 0 if ratings.empty?
        ratings.map{ |r| r.score }.sum / ratings.count.to_f
    end

    def to_s
        "#{name} #{brewery.name}"
    end

end
