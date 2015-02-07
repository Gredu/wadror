require 'rails_helper'

include OwnTestHelper

describe 'Rating' do
    let!(:brewery) { FactoryGirl.create :brewery, name:'Koff' }
    let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
    let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
    let!(:user) { FactoryGirl.create :user }


    before :each do
        sign_in(username: 'Pekka', password: 'Foobar1')
    end

    it 'when given, is registered to the beer and user who is signed in' do
        visit new_rating_path
        select('iso 3', from:'rating[beer_id]')
        fill_in('rating[score]', with:'15')

        expect{
            click_button 'Create Rating'
        }.to change{ Rating.count }.from(0).to(1)

        expect(user.ratings.count).to eq(1)
        expect(beer1.ratings.count).to eq(1)
        expect(beer1.average_rating).to eq(15.0)
    end

    describe 'Rating counts' do 
        let!(:brewery) { FactoryGirl.create :brewery, name:'Koff' }
        let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
        let!(:user) { FactoryGirl.create :user }
        let!(:user1) { FactoryGirl.create :user, username: 'Matti' }
        let!(:user2) { FactoryGirl.create :user, username: 'Mikko' }
        let!(:rating1) { FactoryGirl.create :fullRating, beer: beer1, user: user }
        let!(:rating2) { FactoryGirl.create :fullRating, beer: beer1, user: user2 }
        let!(:rating3) { FactoryGirl.create :fullRating, beer: beer1, user: user2 }
        # user.ratings << FactoryGirl.create(:rating)
        it 'shows rating count when there is three ratings' do
            visit ratings_path
            expect(page).to have_content 'Number of ratings: 3'
        end

        it 'shows only own ratings user has done, which should be 1' do
            visit user_path(user)
            expect(page).to have_content user.username
            expect(page).to have_content 'has made 1 rating'
        end

        it "shows user's rating (incremented by 1), which should be 2" do
            FactoryGirl.create :fullRating, beer: beer1, user: user
            visit user_path(user)
            expect(page).to have_content 'has made 2 ratings'
        end

        it "should not show other user's ratings, when user has no ratings" do
            visit user_path(user1)
            puts page.html
            expect(page).to have_content 'has not yet rated any beers'
        end

        it "should show Matti's ratings, which should be 2" do
            visit user_path(user2)
            expect(page).to have_content 'has made 2 ratings'
        end
    end

    describe 'When user is deleted' do
    end
end
