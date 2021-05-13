module Items
  class LabelsController < NestedResourcesController
    include AccountLayout

    def self.resource
      Label
    end

    def self.parent_resource
      Item
    end

    def permitted_params
      [:text, :account_id, :item_id]
    end

    def assign_attributes
      resource.user = current_user
      resource.account ||= parent_resource.account
      resource.item ||= parent_resource
      resource.text ||= parent_resource.name
    end
  end
end
