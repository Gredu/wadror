require 'rails_helper'

RSpec.describe "BeerClubs", type: :request do
  describe "GET /beer_clubs" do
    it "works! (now write some real specs)" do
      get beer_clubs_path
      expect(response).to have_http_status(200)
    end
  end
end
