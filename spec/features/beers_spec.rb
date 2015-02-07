require 'rails_helper'

include OwnTestHelper

describe 'Beer' do
    before :each do
        FactoryGirl.create :user
        FactoryGirl.create :brewery
        sign_in(username: 'Pekka', password: 'Foobar1')
    end

    it 'has right content when visiting beer creation site' do
        visit new_beer_path
        expect(page).to have_content 'New Beer'
    end

    it 'can add beer if it is valid' do
        visit new_beer_path
        fill_in('beer[name]', with:'NewBeer')
        select('Weizen', from:'beer[style]')
        select('anonymous', from:'beer[brewery_id]')

        expect{
            click_button 'Create Beer'
        }.to change{ Beer.count }.from(0).to(1)
    end

    it 'it does not add beer, if name is not given' do
        visit new_beer_path
        select('Weizen', from:'beer[style]')
        select('anonymous', from:'beer[brewery_id]')
        click_button 'Create Beer'
        expect(Beer.count).to eq(0)
        expect(page).to have_content "Name can't be blank"
    end
end
