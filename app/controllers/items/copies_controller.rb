module Items
  class CopiesController < NestedResourcesController
    DEFAULT_NUMBER_OF_COPIES = 1

    include AccountLayout
    include ActionView::Helpers::TextHelper

    skip_before_action :set_account, only: :create

    def self.parent_resource
      Item
    end

    def self.resource
      ItemCopy
    end

    protected
      def set_new_resource
        self.resource = ItemCopy.new item: parent_resource
      end

      def create_redirect_url
        resource.item&.container || resource.item
      end

      def create_notice
        "Created #{pluralize resource.copies.size, "copy"} of #{resource.item.name}"
      end

      def assign_attributes
        @item_copy.user = current_user
        @item_copy.number_of_copies ||= DEFAULT_NUMBER_OF_COPIES
      end

      def permitted_params
        [:number_of_copies, :item_id, :account_id]
      end
  end
end
