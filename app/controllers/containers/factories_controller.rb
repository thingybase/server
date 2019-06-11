module Containers
  class FactoriesController < NestedResourcesController
    include AccountLayout

    def self.resource
      ApplicationFactory
    end

    def self.parent_resource
      Container
    end

    def permitted_params
      [:name, :account_id, :container_id]
    end

    def assign_attributes
      self.resource.user = current_user
      self.resource.account ||= parent_resource.account
      self.resource.container ||= parent_resource
    end
  end
end
