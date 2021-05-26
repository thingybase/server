module Moves
  class MovementBuildersController < NestedResourcesController
    include AccountLayout

    protected
      def self.resource
        MovementBuilder
      end

      def self.parent_resource
        Move
      end

      def navigation_key
        "Moving"
      end

      def assign_attributes
        @movement_builder.move = @move
        @movement_builder.user = current_user
        @movement_builder.account = @account
      end

      def permitted_params
        [:name, :account_id, :destination_id]
      end

      def create_redirect_url
        movement_url @movement_builder.movement
      end
  end
end
