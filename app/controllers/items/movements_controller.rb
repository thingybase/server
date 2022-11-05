module Items
  class MovementsController < Oxidizer::NestedResourcesController
    include AccountLayout
    before_action :redirect_to_existing_movement, only: :new

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

    private
      def redirect_to_existing_movement
        redirect_to @item.movement if @item.movement
      end
  end
end
