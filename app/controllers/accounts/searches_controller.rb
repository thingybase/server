class Accounts::SearchesController < ApplicationController
  include AccountLayout

  before_action :authenticate_user

  def index
    containers = policy_scope(Container).includes(:parent)
    items = policy_scope(Item).includes(:container)

    @search = Search.new(
      phrase: params[:search],
      items: items,
      containers: containers,
      container: containers.find_by_id(params[:container_id])
    )
  end
end
