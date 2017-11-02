class SessionsController < ApplicationController
  # TODO: Enable this when everything gets locked down.
  # skip_before_action :verify_authorized, only: :create
  # TODO: Really? This seems dangerous
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]
  skip_before_action :authenticate_user, only: [:new, :create]
  skip_after_action :verify_authorized

  def create
    if user = User.find_or_create_from_auth_hash(auth_hash)
      redirect_url = access_denied_url || teams_url
      reset_session # Prevents session fixation attacks
      self.current_user = user
      redirect_to redirect_url
    else
      raise "Couldn't create user from auth hash"
    end
  end

  def new
    if Rails.env.production?
      redirect_to "/auth/google_oauth2"
    else
      # TODO: Replace this with a real login or a bunch of buttons.
      redirect_to "/auth/developer"
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end

  protected
    def auth_hash
      request.env['omniauth.auth']
    end
end
