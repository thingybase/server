module Containers
  class LabelsController < NestedResourcesController
    include AccountLayout

    def self.resource
      Label
    end

    def self.parent_resource
      Container
    end

    def permitted_params
      [:text, :account_id, :container_id]
    end

    def assign_attributes
      self.resource.user = current_user
      self.resource.account ||= parent_resource.account
      self.resource.labelable ||= parent_resource
      self.resource.text ||= parent_resource.name
    end
  end
end
