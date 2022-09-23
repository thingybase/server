module Labels
  class ItemsController < Oxidizer::NestedResourcesController
    include AccountLayout
    include ResourceAnalytics

    def self.resource
      Item
    end

    def self.parent_resource
      Label
    end

    def permitted_params
      [:name, :account_id, :item_global]
    end

    def assign_attributes
      self.resource.user = current_user
      self.resource.account ||= parent_resource.account
      self.resource.label ||= parent_resource
      self.resource.name ||= parent_resource.text
    end
  end
end
