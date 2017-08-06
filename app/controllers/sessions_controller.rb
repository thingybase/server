class SessionsController < ApplicationController
  # TODO: Enable this when everything gets locked down.
  # skip_before_action :verify_authorized, only: :create
  # TODO: Really? This seems dangerous
  skip_before_action :verify_authenticity_token, only: :create

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
