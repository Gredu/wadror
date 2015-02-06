require 'rails_helper'

RSpec.describe User, type: :model do

    it 'has the username set correctly' do
        user = User.new username:'Pekka'
        expect(user.username).to eq('Pekka')
    end

    it 'is not saved without a password' do
        user = User.create username:'Pekka'
        expect(user).not_to be_valid
        expect(User.count).to eq(0)
    end

    it 'is is not saved with too short password' do
        user = User.create username:"lyhyt", password:"sa", password_confirmation:"sa"
        expect(user).not_to be_valid
        expect(User.count).to eq(0)
    end

    it 'is is not saved with password containings only characters' do
        user = User.create username:"vainkirjaimia", password:"saapuvaa", password_confirmation:"saapuvaa"
        expect(user).not_to be_valid
        expect(User.count).to eq(0)
    end

    describe 'favorite beer' do
        let(:user){ FactoryGirl.create(:user) }

        it 'has method for determing the favorite_beer' do
            user = FactoryGirl.create(:user)
            expect(user).to respond_to(:favorite_beer)
        end

        it 'without ratings does not have a favorite beer' do
            user = FactoryGirl.create(:user)
            expect(user.favorite_beer).to eq(nil)
        end

        it 'is the only rated if only one rating' do
            beer = FactoryGirl.create(:beer)
            rating = FactoryGirl.create(:rating, beer:beer, user:user)

            expect(user.favorite_beer).to eq(beer)
        end

        it 'is the one with highest rating if several rated' do
            # create_beer_with_rating(10, user)
            # create_beer_with_rating(7, user)
            # best = create_beer_with_rating(25, user)

            create_beers_with_ratings(10, 20, 15, 7, 9, user)
            best = create_beer_with_rating(25, user)

            # beer1 = FactoryGirl.create(:beer)
            # beer2 = FactoryGirl.create(:beer)
            # beer3 = FactoryGirl.create(:beer)
            # rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
            # rating2 = FactoryGirl.create(:rating, score:25,  beer:beer2, user:user)
            # rating3 = FactoryGirl.create(:rating, score:9, beer:beer3, user:user)

            # expect(user.favorite_beer).to eq(beer2)
            expect(user.favorite_beer).to eq(best)

        end
    end

    describe "with a proper password" do
        # let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
        let!(:user){ FactoryGirl.create(:user) }

        it "is saved" do
            expect(user).to be_valid
            expect(User.count).to eq(1)
        end

        it "and with two ratings, has the correct average rating" do
            # rating = Rating.new score:10
            # rating2 = Rating.new score:20

            user.ratings << FactoryGirl.create(:rating)
            user.ratings << FactoryGirl.create(:rating2)

            # user.ratings << rating
            # user.ratings << rating2

            expect(user.ratings.count).to eq(2)
            expect(user.average_rating).to eq(15.0)
        end
    end
end

def create_beer_with_rating(score, user)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score: score, beer: beer, user: user)
    beer
end

def create_beers_with_ratings(*scores, user)
    scores.each do |score|
        create_beer_with_rating(score, user)
    end
end
