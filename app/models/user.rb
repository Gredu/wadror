class User < ActiveRecord::Base
    include RatingAverage

    # validates :username, length: { minimum: 3 }
    # käyttäjällä on monta ratingia
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_secure_password

    validates :username, uniqueness: true,
        length: { minimum: 3, maximum: 15}

    validates :password, length: { minimum: 4 },
        format: { with: /(?=.*\d)(?=.*[A-Z])/, message: "password needs atleast one capital and one digit number" }

end
