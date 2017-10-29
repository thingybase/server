require "rails_helper"

RSpec.describe TeamInvitationResponsesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/team_invitation_responses").to route_to("team_invitation_responses#index")
    end

    it "routes to #new" do
      expect(:get => "/team_invitation_responses/new").to route_to("team_invitation_responses#new")
    end

    it "routes to #show" do
      expect(:get => "/team_invitation_responses/1").to route_to("team_invitation_responses#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/team_invitation_responses/1/edit").to route_to("team_invitation_responses#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/team_invitation_responses").to route_to("team_invitation_responses#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/team_invitation_responses/1").to route_to("team_invitation_responses#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/team_invitation_responses/1").to route_to("team_invitation_responses#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/team_invitation_responses/1").to route_to("team_invitation_responses#destroy", :id => "1")
    end

  end
end
