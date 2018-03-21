class ResourcesController < ApplicationController
  before_action :authenticate_user
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  before_action :authorize_resource, only: [:show, :edit, :destroy]
  helper_method :resource_name, :resource_class

  def self.resource
    raise NotImplementedError, "ResourcesController.resource must be an ActiveModel or ActiveRecord class"
  end

  def index
    self.resources = resource_scope
  end

  def show
  end

  def new
    self.resource = resource_class.new
    assign_attributes
    authorize_resource
  end

  def edit
  end

  def create
    self.resource = resource_class.new(resource_params)
    assign_attributes
    authorize_resource

    respond_to do |format|
      if resource.save
        format.html { redirect_to create_redirect_url, notice: "#{resource_name} was successfully created." }
        format.json { render :show, status: :created, location: resource }
      else
        format.html { render :new }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    resource.assign_attributes(resource_params)
    assign_attributes
    authorize_resource

    respond_to do |format|
      if resource.save
        format.html { redirect_to update_redirect_url, notice: "#{resource_name} was successfully updated." }
        format.json { render :show, status: :ok, location: resource }
      else
        format.html { render :edit }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    resource.destroy
    respond_to do |format|
      format.html { redirect_to destroy_redirect_url, notice: "#{resource_name} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  protected
    # Gets the resource name of the ActiveRecord model for use by
    # instance methods in this controller.
    def resource_name
      resource_class.model_name
    end

    def resource_class
      self.class.resource
    end

    # Permitted params the resource controller allows
    def permitted_params
      []
    end

    # A scope used for collections scoped by Pundit auth.
    def resource_scope
      policy_scope.joins(:user)
    end

    # `policy_scope` is defined by Pundit.
    def policy_scope(scope = resource_class)
      super(scope)
    end

    # Sets instance variable for templates to match the model name. For
    # example, `Team` model name would set the `@team` instance variable
    # for template access.
    def resource=(value)
      instance_variable_set("@#{resource_name.singular}", value)
    end

    # Sets instance variable for templates to match the model name. For
    # example, `Team` model name would set the `@teams` instance variable
    # for template access.
    def resources=(value)
      instance_variable_set("@#{resource_name.plural}", value)
    end

    # Gets instance variable for templates to match the model name. For
    # example, `Team` model name would get the `@team` instance variable.
    def resource
      instance_variable_get("@#{resource_name.singular}")
    end

    # Gets instance variable for templates to match the model name. For
    # example, `Team` model name would get the `@teams` instance variable.
    def resources
      instance_variable_get("@#{resource_name.plural}")
    end

    # A hook that allows sub-classes to assign attributes to a model.
    def assign_attributes
      resource.user = current_user if resource.respond_to? :user=
    end

    # Redirect to this url after a resource is created
    def create_redirect_url
      resource
    end

    # Redirect to this url after a resource is updated
    def update_redirect_url
      resource
    end

    # Redirect to this url after a resource is destroyed
    def destroy_redirect_url
      resource_name.plural.to_sym
    end

    def resource_route_key
      :id
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      self.resource = resource_class.find params[resource_route_key]
    end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(resource_name.singular).permit(permitted_params)
    end

    # Authorizse resource with Pundit.
    def authorize_resource
      authorize resource
    end
end
