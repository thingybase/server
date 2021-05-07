class SignupsController < ApplicationController
  skip_security!
  before_action :ensure_authentic_email
  layout "focused"

  def new
    @user = User.new(session_params)
  end

  def create
    @user = User.new(resource_params)

    if @user.save
      redirect_url = access_denied_url || launch_url
      reset_session
      self.current_user = @user
      redirect_to redirect_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def resource_params
      session_params.merge permitted_params
    end

    def permitted_params
      params.require(:user).permit(:name)
    end

    def session_params
      { email: session[:authentic_email] }
    end

    def ensure_authentic_email
      redirect_to new_user_resolution_url if session_params[:email].blank?
    end
end
