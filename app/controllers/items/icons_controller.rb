module Items
  class IconsController < NestedWeakResourceController
    include AccountLayout

    def self.parent_resource
      Item
    end

    def edit
      @icons = SvgIconFile.all
    end

    def permitted_params
      [:icon_key]
    end

    def assign_attributes
      self.resource.user = current_user
      self.resource.account ||= parent_resource.account
      self.resource.parent ||= parent_resource
    end
  end
end
