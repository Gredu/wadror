require 'rails_helper'

RSpec.describe "beer_clubs/new", type: :view do
  before(:each) do
    assign(:beer_club, BeerClub.new(
      :name => "MyString",
      :string => "MyString",
      :founded => "MyString",
      :integer => "MyString",
      :city => "MyString",
      :string => "MyString"
    ))
  end

  it "renders new beer_club form" do
    render

    assert_select "form[action=?][method=?]", beer_clubs_path, "post" do

      assert_select "input#beer_club_name[name=?]", "beer_club[name]"

      assert_select "input#beer_club_string[name=?]", "beer_club[string]"

      assert_select "input#beer_club_founded[name=?]", "beer_club[founded]"

      assert_select "input#beer_club_integer[name=?]", "beer_club[integer]"

      assert_select "input#beer_club_city[name=?]", "beer_club[city]"

      assert_select "input#beer_club_string[name=?]", "beer_club[string]"
    end
  end
end
