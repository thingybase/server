require "rails_helper"

RSpec.describe AcknowledgementsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/acknowledgements").to route_to("acknowledgements#index")
    end

    it "routes to #new" do
      expect(:get => "/acknowledgements/new").to route_to("acknowledgements#new")
    end

    it "routes to #show" do
      expect(:get => "/acknowledgements/1").to route_to("acknowledgements#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/acknowledgements/1/edit").to route_to("acknowledgements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/acknowledgements").to route_to("acknowledgements#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/acknowledgements/1").to route_to("acknowledgements#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/acknowledgements/1").to route_to("acknowledgements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/acknowledgements/1").to route_to("acknowledgements#destroy", :id => "1")
    end

  end
end
