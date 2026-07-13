require "rails_helper"

RSpec.describe "Items", type: :request do
  let(:user) { create(:user) }
  let(:account) { create(:account, user: user) }

  before { sign_in user }

  describe "GET /accounts/:account_id/items" do
    it "lists the account's items" do
      create(:item, account: account, user: user, name: "Camping lantern")
      get account_items_path(account)
      expect(response.body).to include("Camping lantern")
    end
  end

  describe "GET /items/:id" do
    it "shows an item" do
      item = create(:item, account: account, user: user, name: "Beach umbrella")
      get item_path(item)
      expect(response.body).to include("Beach umbrella")
    end

    it "shows a container and its contents" do
      container = create(:item, account: account, user: user, container: true)
      create(:item, account: account, user: user, parent: container, name: "Camping stove")
      get item_path(container)
      expect(response.body).to include("Camping stove")
    end
  end

  describe "POST /items" do
    it "creates an item" do
      expect {
        post items_path, params: { item: { name: "Camping stove", account_id: account.id } }
      }.to change(account.items, :count).by(1)
    end
  end

  describe "PATCH /items/:id" do
    it "updates the item" do
      item = create(:item, account: account, user: user)
      patch item_path(item), params: { item: { name: "Renamed" } }
      expect(item.reload.name).to eq("Renamed")
    end
  end

  describe "DELETE /items/:id" do
    it "destroys the item" do
      item = create(:item, account: account, user: user)
      expect { delete item_path(item) }.to change(Item, :count).by(-1)
    end
  end

  describe "another account's item" do
    it "is forbidden" do
      other_item = create(:item)
      get item_path(other_item)
      expect(response).to have_http_status(:forbidden)
    end

    it "cannot be updated" do
      other_item = create(:item, name: "Theirs")
      patch item_path(other_item), params: { item: { name: "Mine now" } }
      expect(other_item.reload.name).to eq("Theirs")
    end
  end
end
