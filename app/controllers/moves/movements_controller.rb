module Moves
  class MovementsController < Oxidizer::NestedResourcesController
    include AccountLayout

    protected
      def self.resource
        Movement
      end

      def self.parent_resource
        Move
      end

      def navigation_key
        "Moving"
      end

      def assign_attributes
        @movement.user = current_user
        @movement.account = @account
        @movement.move ||= @move
      end

      def permitted_params
        [:account_id, :origin_id, :destination_id]
      end

      def create_redirect_url
        movement_url @movement
      end
  end
end
