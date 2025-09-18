class UsersController < ApplicationController
  layout false

  include Superview::Actions
  include Superform::Rails::StrongParameters

  include Views::Users

  before_action do
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    if save Form.new(@user)
      redirect_to action: :show
    else
      render component(:edit), status: :unprocessable_entity
    end
  end
end
