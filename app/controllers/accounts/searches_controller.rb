class Accounts::SearchesController < ApplicationController
  before_action :authenticate_user

  def index
    @search = Search.new(phrase: params[:search], items: policy_scope(Item), containers: policy_scope(Container))
  end
end
