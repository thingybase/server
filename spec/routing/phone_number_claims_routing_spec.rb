require "rails_helper"

RSpec.describe PhoneNumberClaimsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/phone_number_claims").to route_to("phone_number_claims#index")
    end

    it "routes to #new" do
      expect(:get => "/phone_number_claims/new").to route_to("phone_number_claims#new")
    end

    it "routes to #show" do
      expect(:get => "/phone_number_claims/1").to route_to("phone_number_claims#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/phone_number_claims/1/edit").to route_to("phone_number_claims#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/phone_number_claims").to route_to("phone_number_claims#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/phone_number_claims/1").to route_to("phone_number_claims#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/phone_number_claims/1").to route_to("phone_number_claims#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/phone_number_claims/1").to route_to("phone_number_claims#destroy", :id => "1")
    end

  end
end
