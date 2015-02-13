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
            expect(page).to have_content 'has not yet rated any beers'
        end

        it "should show Matti's ratings, which should be 2" do
            visit user_path(user2)
            expect(page).to have_content 'has made 2 ratings'
        end
    end

    describe 'When user is deleted' do
        let!(:brewery) { FactoryGirl.create :brewery, name:'Koff' }
        let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
        # let!(:pekka) { FactoryGirl.create :user }
        let!(:matti) { FactoryGirl.create :user, username: 'Matti' }
        let!(:mikko) { FactoryGirl.create :user, username: 'Mikko' }
        let!(:rating1) { FactoryGirl.create :fullRating, beer: beer1, user: user }
        let!(:rating2) { FactoryGirl.create :fullRating, beer: beer1, user: matti }
        let!(:rating3) { FactoryGirl.create :fullRating, beer: beer1, user: matti }
        let!(:rating4) { FactoryGirl.create :fullRating, beer: beer1, user: mikko }
        let!(:rating5) { FactoryGirl.create :fullRating, beer: beer1, user: mikko }
        let!(:rating6) { FactoryGirl.create :fullRating, beer: beer1, user: mikko }

        it "should have three users, before deletion" do
            visit users_path
            expect(page).to have_content 'Listing Users'
            expect(page).to have_content 'Pekka'
            expect(page).to have_content 'Matti'
            expect(page).to have_content 'Mikko'
        end

        it "Pekka should have one rating, before deletion" do
            visit user_path(user)
            expect(page).to have_content 'has made 1 rating'
        end

        it "Matti should have two rating, before deletion" do
            visit user_path(matti)
            expect(page).to have_content 'has made 2 rating'
        end

        it "Mikko should have three rating, before deletion" do
            visit user_path(mikko)
            expect(page).to have_content 'has made 3 rating'
        end

        it "should have total ratings of 6 before deletion" do
            visit ratings_path
            expect(page).to have_content 'Number of ratings: 6'
        end

        it "Pekka should have 0 ratings after deleting one rating" do
            visit user_path(user)
            
            expect{
                click_on 'delete'
            }.to change{ Rating.count }.from(6).to(5)
            expect(current_path).to eq(user_path(user))
            visit ratings_path
            expect(page).to have_content 'Number of ratings: 5'
        end

        it "should delete one of Mikko's ratings" do
            sign_in(username: 'Mikko', password: 'Foobar1')
            visit user_path(mikko)

            expect(page).to have_content 'has made 3 ratings'
            expect{
                first(:link, "delete").click
            }.to change{ Rating.count }.from(6).to(5)
            expect{
                first(:link, "delete").click
            }.to change{ Rating.count }.from(5).to(4)
            expect{
                first(:link, "delete").click
            }.to change{ Rating.count }.from(4).to(3)
            expect(page).to have_content 'has not yet rated any beers'
        end
    end

end
