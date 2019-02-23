class Accounts::SearchesController < ApplicationController
  include AccountLayout

  before_action :authenticate_user

  def index
    @search = Search.new(phrase: params[:search],
      items: policy_scope(Item).includes(:container),
      containers: policy_scope(Container).includes(:parent))
  end
end
