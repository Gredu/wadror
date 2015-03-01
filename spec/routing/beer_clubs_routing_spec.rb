require "rails_helper"

RSpec.describe BeerClubsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/beer_clubs").to route_to("beer_clubs#index")
    end

    it "routes to #new" do
      expect(:get => "/beer_clubs/new").to route_to("beer_clubs#new")
    end

    it "routes to #show" do
      expect(:get => "/beer_clubs/1").to route_to("beer_clubs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/beer_clubs/1/edit").to route_to("beer_clubs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/beer_clubs").to route_to("beer_clubs#create")
    end

    it "routes to #update" do
      expect(:put => "/beer_clubs/1").to route_to("beer_clubs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/beer_clubs/1").to route_to("beer_clubs#destroy", :id => "1")
    end

  end
end
