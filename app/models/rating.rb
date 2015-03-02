class Rating < ActiveRecord::Base

  belongs_to :beer
  belongs_to :user, dependent: :destroy  # rating kuuluu myös käyttäjään

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                    only_integer: true }

  scope :top_beers, -> { all.limit 3 }
  scope :top_breweries, -> { all.limit 3 }
  scope :top_styles, -> { all.limit 3 }

  def to_s
    # (Beer.find_by id: beer_id).name + " " + score.to_s
    "#{beer.name} #{score}"
  end

  def self.top(n)
    sorted_by_rating_in_desc_order = Rating.all.sort_by{ |b| -(b.score||0) }.take n
  end

end
