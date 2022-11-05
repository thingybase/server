module Moves
  class MovementBuildersController < Oxidizer::NestedResourcesController
    include AccountLayout

    protected
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
