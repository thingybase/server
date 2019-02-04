module Containers
  class ChildrenController < NestedResourcesController
    include AccountLayout

    def self.resource
      Container
    end

    def self.parent_resource
      Container
    end

    def permitted_params
      [:name, :account_id, :uuid, :parent_id]
    end

    def resource_key
      :uuid
    end

    def parent_resource_key
      :uuid
    end

    def parent_resource_name
      "container_parent"
    end

    def parent_resource_id_param
      "container_id"
    end

    def nested_resource_scope
      policy_scope parent_resource.children
    end

    def assign_attributes
      self.resource.user = current_user
      self.resource.account ||= parent_resource.account
      self.resource.parent ||= parent_resource
    end
  end
end
