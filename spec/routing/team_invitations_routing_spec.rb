require "rails_helper"

RSpec.describe TeamInvitationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/team_invitations").to route_to("team_invitations#index")
    end

    it "routes to #new" do
      expect(:get => "/team_invitations/new").to route_to("team_invitations#new")
    end

    it "routes to #show" do
      expect(:get => "/team_invitations/1").to route_to("team_invitations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/team_invitations/1/edit").to route_to("team_invitations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/team_invitations").to route_to("team_invitations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/team_invitations/1").to route_to("team_invitations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/team_invitations/1").to route_to("team_invitations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/team_invitations/1").to route_to("team_invitations#destroy", :id => "1")
    end

  end
end
