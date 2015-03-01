class User < ActiveRecord::Base
    include RatingAverage
    # favorite_available_by :style, :brewery

    # validates :username, length: { minimum: 3 }
    # käyttäjällä on monta ratingia
    has_many :ratings, dependent: :destroy
    has_many :beers, through: :ratings
    has_many :membership
    has_secure_password

    validates :username, uniqueness: true,
        length: { minimum: 3, maximum: 15}

    validates :password, length: { minimum: 4 }
    # validates :password, format: { with: /(?=.*\d)(?=.*[A-Z])/, message: "password needs atleast one capital and one digit number" }
    validates :password, format: { with: /\d.*[A-Z]|[A-Z].*\d/, message: "password needs atleast one capital and one digit number" }

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |b| -(b.ratings.count||0) }.take n
  end

  def favorite_brewery
    return nil if ratings.empty?
    brewery_ratings = rated_breweries.inject([]) do |ratings, brewery|
      ratings << {
        brewery: brewery,
        rating: rating_of_brewery(brewery) }
    end
 
    brewery_ratings.sort_by { |brewery| brewery[:rating] }.last[:brewery]
#   favorite :brewery
  end

  def favorite_style
    return nil if ratings.empty?
    style_ratings = rated_styles.inject([]) do |ratings, style|
      ratings << {
        style: style,
        rating: rating_of_style(style) }
    end
 
    style_ratings.sort_by { |style| style[:rating] }.last[:style]
    favorite :style
  end

  def rated_breweries
    ratings.map{ |r| r.beer.brewery }.uniq
  end

  def rated_styles
    ratings.map{ |r| r.beer.style }.uniq
  end

  def rating_of_brewery(brewery)
    ratings_of_brewery = ratings.select do |r|
      r.beer.brewery == brewery
    end
    ratings_of_brewery.map(&:score).sum / ratings_of_brewery.count
  end

  def rating_of_style(style)
    ratings_of_style = ratings.select do |r|
      r.beer.style == style
    end
    ratings_of_style.map(&:score).sum / ratings_of_style.count
  end


  # Refractoring:

  def rated(category)
    ratings.map{ |r| r.beer.send(category) }.uniq
  end

  def rating_of(category, item)
    ratings_of_item = ratings.select do |r|
      r.beer.send(category) == item
    end
    ratings_of_item.map(&:score).sum / ratings_of_item.count
  end

# def favorite(category)
#   return nil if ratings.empty?
#
#   category_ratings = rated(category).inject([]) do |set, item|
#     set << {
#       item: item,
#       rating: rating_of(category, item) }
#   end
#
#   category_ratings.sort_by { |item| item[:rating] }.last[:item]
# end
#
# def method_missing(method_name, *args, &block)
#   if method_name =~ /^favorite_/
#     category = method_name[9..-1].to_sym
#     self.favorite category
#   else
#     return super
#   end
# end

end
