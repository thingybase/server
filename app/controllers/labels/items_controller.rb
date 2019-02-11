module Labels
  class ItemsController < NestedResourcesController
    include AccountLayout

    def self.resource
      Item
    end

    def self.parent_resource
      Label
    end

    def permitted_params
      [:name, :account_id, :labelable_global]
    end

    def assign_attributes
      self.resource.user = current_user
      self.resource.account ||= parent_resource.account
      self.resource.label ||= parent_resource
      self.resource.name ||= parent_resource.text
    end

    def parent_resource_key
      :uuid
    end
  end
end
