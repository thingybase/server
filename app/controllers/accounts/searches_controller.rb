class Accounts::SearchesController < ApplicationController
  include AccountLayout

  before_action :authenticate_user

  def index
    items = policy_scope(@account.items)

    @search = Search.new(
      phrase: params[:search],
      items: items
    )
  end
end
