class UsersController < Oxidizer::ResourcesController
  layout false

  def self.resource = User

  # layout -> { Views::Layouts::App.new(title: @user.name) }

  def show
    render Views::Users::Show.new(@user)
  end

  def permitted_params
    [:name, :email]
  end

  protected

  def resource_scope
    policy_scope
  end
end
