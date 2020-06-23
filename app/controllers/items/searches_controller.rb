class Items::SearchesController < ApplicationController
  include AccountLayout

  before_action :authenticate_user

  helper_method :resource

  def index
    items = policy_scope(resource.children)

    @search = Search.new(
      phrase: params[:search],
      items: items
    )
  end

  private
    def resource
      Item.find_resource params[:item_id]
    end

    def find_account
      resource.account
    end
end
