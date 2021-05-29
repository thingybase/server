module Items
  class MovementsController < NestedResourcesController
    include AccountLayout

    def self.parent_resource
      Item
    end

    def self.resource
      Movement
    end

    private
      def create_redirect_url
        movement_url @movement
      end

      def permitted_params
        [:destination_id]
      end

      def navigation_key
        "Items"
      end

      def assign_attributes
        resource.move = @account.move
        resource.user = current_user
        resource.account = parent_resource.account
        resource.origin = parent_resource
        resource.destination ||= parent_resource.parent
      end
  end
end
