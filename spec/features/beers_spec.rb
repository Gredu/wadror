require 'rails_helper'

include OwnTestHelper

describe 'Beer' do
    before :each do
        FactoryGirl.create :user
        FactoryGirl.create :brewery
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
        puts page.html
        expect(Beer.count).to eq(0)
        expect(page).to have_content "Name can't be blank"
    end
end

# Tee testi, joka varmistaa, että järjestelmään voidaan lisätä www-sivun kautta olut, jos oluen nimikenttä saa validin arvon (eli se on epätyhjä). Tee myös testi, joka varmistaa, että selain palaa oluen luomissivulle ja näyttää asiaan kuuluvan virheilmoituksen jos oluen nimi ei ole validi, ja että tälläisessä tapauksessa tietokantaan ei talletu mitään.
#
# HUOM: ohjelmassasi on ehkä bugi tilanteessa, jossa yritetään luoda epävalidin nimen omaava olut. Kokeile toiminnallisuutta selaimesta. Syynä tälle on selitetty viikon alussa, kohdassa https://github.com/mluukkai/WebPalvelinohjelmointi2015/blob/master/web/viikko4.md#muutama-huomio. Korjaa vika koodistasi.
#
# Muista ongelmatilanteissa komento save_and_open_page!
