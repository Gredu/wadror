require 'rails_helper'

describe 'Places' do

    it 'if one is returned by the API, it is shown at the page' do
        allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return(
            [ Place.new(name: 'Oljenkorsi', id: 1) ]
        )

        visit places_path
        fill_in('city', with: 'kumpula')
        click_button 'Search'
        expect(page).to have_content 'Oljenkorsi'
    end

    it 'if more is returned by the API, show all at the page' do
        allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return(
            [ 
                Place.new(name: 'Oljenkorsi', id: 1),
                Place.new(name: 'Katajannokka', id: 2),
                Place.new(name: 'Sörnäinen', id: 3)
            ]
        )

        visit places_path
        fill_in('city', with: 'kumpula')
        click_button 'Search'
        expect(page).to have_content 'Oljenkorsi'
        expect(page).to have_content 'Katajannokka'
        expect(page).to have_content 'Sörnäinen'
    end

    it 'if none is returned by the API, show notification' do
        allow(BeermappingApi).to receive(:places_in).with('kumpula').and_return([])

        visit places_path
        fill_in('city', with: 'kumpula')
        click_button 'Search'
        expect(page).to have_content "No locations in kumpula"
    end

end
