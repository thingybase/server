class UsersController < Oxidizer::ResourcesController
  layout false

  def self.resource = User

  layout -> { Views::Layouts::App.new(title: @user.name) }

  include Superform::Rails::StrongParameters

  helper_method :form

  def show
    render Views::Users::Show.new(@user)
  end

  def update
    if save form
      redirect_to action: :show
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def permitted_params
    [:name, :email]
  end

  protected

  def form = Views::Users::Form.new(@user)

  def resource_scope
    policy_scope
  end
end
