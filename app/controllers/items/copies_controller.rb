module Items
  class CopiesController < Oxidizer::NestedResourcesController
    DEFAULT_NUMBER_OF_COPIES = 1

    include AccountLayout
    include ActionView::Helpers::TextHelper

    def self.parent_resource
      Item
    end

    def self.resource
      ItemCopy
    end

    protected
      def find_account
        parent_resource.account
      end

      def assign_new_resource
        self.resource = ItemCopy.new item: parent_resource
      end

      # Send the person to the item if there's only one copy created
      def create_redirect_url
        if resource.number_of_copies.to_i > 1 and resource.item.parent
          resource.item.parent
        else
          resource.copies.first
        end
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
