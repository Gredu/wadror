require 'rails_helper'

RSpec.describe Beer, type: :model do

    it 'is saved when it has name and style' do
        Beer.create name:'Koff', style:'lager'
        expect(Beer.count).to eq(1)
    end

    it 'is not saved when name is not given' do
        beer = Beer.create style:'lager'
        expect(beer).not_to be_valid
        expect(Beer.count).to eq(0)
    end

    it 'is not saved when name is empty' do
        beer = Beer.create name:'', style:'lager'
        expect(beer).not_to be_valid
        expect(Beer.count).to eq(0)
    end

    it 'is not saved when style is not given' do
        beer = Beer.create name:'Koff'
        expect(beer).not_to be_valid
        expect(Beer.count).to eq(0)
    end

    it 'is not saved when style is not given' do
        beer = Beer.create name:'Koff', style:''
        expect(beer).not_to be_valid
        expect(Beer.count).to eq(0)
    end





  # oluen luonti ei onnistu, jos sille ei määritellä tyyliä

end
