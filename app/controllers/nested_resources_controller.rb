class NestedResourcesController < ResourcesController
  before_action :set_parent_resource
  before_action :set_resources, only: :index

  protected
    def self.parent_resource
      raise NotImplementedError, "ShallowResourcesController.parent_resource must be an ActiveModel or ActiveRecord class"
    end

    def set_resources
      self.resources = nested_resource_scope
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_parent_resource
      query = {}
      query[parent_resource_key] = params[parent_resource_id_param]
      self.parent_resource = self.class.parent_resource.find_by! **query
    end

    # If we're deep, we want to show only members that are scoped
    # from within an index.
    def nested_resource_scope
      query = {}
      query[parent_resource_foreign_key] = parent_resource
      resource_scope.where(**query)
    end

    # Assumes the route key is the foreign key, which is usually the case.
    # This can be overridden if its not the case or the `nested_resource_scope`
    # can be over-ridden.
    def parent_resource_id_param
      parent_resource_foreign_key
    end

    # Key used to find the parent resource via ActiveRecord. Typically this is the primary key of the record,
    # but it would be a different field if you don't want to expose users to primary keys.
    def parent_resource_key
      :id
    end

  private
    def resource_params
      # Optionally allow the resource params because nested resources usually
      # allow a POST request with no params that create a resource.
      if params.key? resource_name
        params.require(resource_name).permit(permitted_params)
      end
    end

    # Sets instance variable for templates to match the model name. For
    # example, `Account` model name would set the `@account` instance variable
    # for template access.
    def parent_resource=(value)
      instance_variable_set("@#{parent_resource_name}", value)
    end

    # Gets instance variable for templates to match the model name. For
    # example, `Account` model name would get the `@account` instance variable.
    def parent_resource
      instance_variable_get("@#{parent_resource_name}")
    end

    # Gets the resource name of the ActiveRecord model for use by
    # instance methods in this controller.
    def parent_resource_name
      self.class.parent_resource.model_name.singular
    end

    def parent_resource_foreign_key
      "#{parent_resource_name}_id".to_sym
    end
end
