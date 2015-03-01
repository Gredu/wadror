require 'rails_helper'

RSpec.describe "beer_clubs/index", type: :view do
  before(:each) do
    assign(:beer_clubs, [
      BeerClub.create!(
        :name => "Name",
        :string => "String",
        :founded => "Founded",
        :integer => "Integer",
        :city => "City",
        :string => "String"
      ),
      BeerClub.create!(
        :name => "Name",
        :string => "String",
        :founded => "Founded",
        :integer => "Integer",
        :city => "City",
        :string => "String"
      )
    ])
  end

  it "renders a list of beer_clubs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "String".to_s, :count => 2
    assert_select "tr>td", :text => "Founded".to_s, :count => 2
    assert_select "tr>td", :text => "Integer".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "String".to_s, :count => 2
  end
end
