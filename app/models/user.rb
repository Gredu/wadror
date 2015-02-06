class User < ActiveRecord::Base
    include RatingAverage

    # validates :username, length: { minimum: 3 }
    # käyttäjällä on monta ratingia
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_secure_password

    validates :username, uniqueness: true,
        length: { minimum: 3, maximum: 15}

    validates :password, length: { minimum: 4 }
    # validates :password, format: { with: /(?=.*\d)(?=.*[A-Z])/, message: "password needs atleast one capital and one digit number" }
    validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/, message: "password needs atleast one capital and one digit number" }

    def favorite_beer
        return nil if ratings.empty?
        # ratings.first.beer
        # ratings.sort_by{ |r| r.score }.last.beer
        # ratings.sort_by(&:score).last.beer
        ratings.order(score: :desc).limit(1).first.beer
    end

end
