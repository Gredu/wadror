require 'rails_helper'

RSpec.describe "beer_clubs/show", type: :view do
  before(:each) do
    @beer_club = assign(:beer_club, BeerClub.create!(
      :name => "Name",
      :string => "String",
      :founded => "Founded",
      :integer => "Integer",
      :city => "City",
      :string => "String"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/String/)
    expect(rendered).to match(/Founded/)
    expect(rendered).to match(/Integer/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/String/)
  end
end
